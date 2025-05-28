#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import psutil
import time
import logging
import os
from datetime import datetime

# 配置日志
def setup_logger():
    # 创建日志目录（如果不存在）
    log_dir = "logs"
    if not os.path.exists(log_dir):
        os.makedirs(log_dir)
    
    # 日志文件名格式：logs/system_monitor_YYYY-MM-DD.log
    log_file = os.path.join(log_dir, f"system_monitor_{datetime.now().strftime('%Y-%m-%d')}.log")
    
    # 配置日志格式
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(levelname)s - %(message)s',
        handlers=[
            logging.FileHandler(log_file),
            logging.StreamHandler()  # 同时输出到控制台
        ]
    )
    return logging.getLogger()

# 获取CPU使用率
def get_cpu_usage():
    return psutil.cpu_percent(interval=1)

# 获取内存使用率
def get_memory_usage():
    return psutil.virtual_memory().percent

# 监控系统资源并记录日志
def monitor_system(logger, check_interval=5, warning_threshold=80, critical_threshold=90):
    logger.info("系统监控已启动 - 监控间隔: %d秒, 警告阈值: %d%%, 严重阈值: %d%%", 
                check_interval, warning_threshold, critical_threshold)
    
    try:
        while True:
            # 获取CPU和内存使用率
            cpu_usage = get_cpu_usage()
            memory_usage = get_memory_usage()
            
            # 记录基本信息
            logger.info(f"CPU使用率: {cpu_usage:.1f}%, 内存使用率: {memory_usage:.1f}%")
            
            # 根据阈值判断并记录警告或严重级别日志
            # CPU 监控
            if cpu_usage >= critical_threshold:
                logger.critical(f"严重: CPU使用率达到 {cpu_usage:.1f}%，超过严重阈值 {critical_threshold}%")
            elif cpu_usage >= warning_threshold:
                logger.warning(f"警告: CPU使用率达到 {cpu_usage:.1f}%，超过警告阈值 {warning_threshold}%")
            
            # 内存监控
            if memory_usage >= critical_threshold:
                logger.critical(f"严重: 内存使用率达到 {memory_usage:.1f}%，超过严重阈值 {critical_threshold}%")
            elif memory_usage >= warning_threshold:
                logger.warning(f"警告: 内存使用率达到 {memory_usage:.1f}%，超过警告阈值 {warning_threshold}%")
            
            # 等待指定的检查间隔
            time.sleep(check_interval)
            
    except KeyboardInterrupt:
        logger.info("系统监控已停止")
    except Exception as e:
        logger.error(f"监控过程中发生错误: {str(e)}")

if __name__ == "__main__":
    # 设置监控参数
    CHECK_INTERVAL = 5       # 每5秒检查一次
    WARNING_THRESHOLD = 80   # 警告阈值：80%
    CRITICAL_THRESHOLD = 90  # 严重阈值：90%
    
    # 初始化日志
    logger = setup_logger()
    
    # 开始监控
    monitor_system(logger, CHECK_INTERVAL, WARNING_THRESHOLD, CRITICAL_THRESHOLD)