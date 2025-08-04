# Use official ROS 2 Humble base image
FROM rdclab/ros:humble-full

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV COLCON_WS=/root/ros2_ws/

# Install necessary packages
RUN apt update && apt install -y \
    python3-colcon-common-extensions \
    python3-vcstool \
    git \
    curl \
    gnupg2 \
    lsb-release \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Initialize rosdep (safe even if already initialized)
RUN rosdep init || true && rosdep update

# Create the workspace directory
RUN mkdir -p ${COLCON_WS}/src

# Set working directory to workspace
WORKDIR ${COLCON_WS}

# Clone UR ROS 2 driver package
RUN git clone -b humble https://github.com/UniversalRobots/Universal_Robots_ROS2_Driver.git src/Universal_Robots_ROS2_Driver

# Import additional required repositories
RUN vcs import src --skip-existing --input src/Universal_Robots_ROS2_Driver/Universal_Robots_ROS2_Driver.humble.repos

# Install dependencies using rosdep
RUN apt update && \
    rosdep install --rosdistro humble --ignore-src --from-paths src -y

# Build the workspace using colcon
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release"

# Source the workspace on container start
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc && \
    echo "source ${COLCON_WS}/install/setup.bash" >> ~/.bashrc