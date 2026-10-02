FROM python:3.10-slim

# 设置工作目录
WORKDIR /app

# 设置时区为中国时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 复制项目文件
COPY main.py push.py config.py log_utils.py scheduler.py ./

# 安装 Python 依赖（scheduler.py 依赖 apscheduler）
RUN python -m pip install --no-cache-dir \
    'requests>=2.32.3' \
    'urllib3>=2.2.3' \
    'apscheduler>=3.10,<4'

# 定时任务由 scheduler.py 负责（CRON_SCHEDULE、RUN_JITTER_SECONDS 由环境变量传入）
CMD ["python", "scheduler.py"]
