# ur5e_docker

### Install
```
git clone https://github.com/RDC-harvesting-robot/ur5e_docker
```

### Execute
```
cd ur5e_docker
./run.sh
```

Set IP Address
Address: 192.168.1.101
Netmask: 255.255.255.0
Gateway: 192.168.1.1

Simulation
```
source install/setup.bash
ros2 launch ur_robot_driver ur_control.launch.py ur_type:=ur5e robot_ip:=yyy.yyy.yyy.yyy use_fake_hardware:=true launch_rviz:=false
```
```
source install/setup.bash
ros2 launch ur_moveit_config ur_moveit.launch.py ur_type:=ur5e launch_rviz:=true use_fake_hardware:=true
```

Real Robot
```
source install/setup.bash
ros2 launch ur_robot_driver ur_control.launch.py ur_type:=ur5e robot_ip:=192.168.1.102 launch_rviz:=false
```
```
source install/setup.bash
ros2 launch ur_moveit_config ur_moveit.launch.py ur_type:=ur5e launch_rviz:=true
```