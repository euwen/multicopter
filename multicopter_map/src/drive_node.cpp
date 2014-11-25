#include <ros/ros.h>
#include <geometry_msgs/Twist.h>

/* subscribe to topic: /mobile_base/commands/velocity
  This topic includes for example
  linear velocity:
  x: 0.1
  y: 0.0
  z: 0.0
  and angular velocity:
  x: 0.0
  y: 0.0
  z: 1.4
  We want to use only linear x and angular z.
  These commands need to be mapped to PWM (0-255) for the flight
*/
class DriveCommands
{
public:
  DriveCommands()
  {
    ros::NodeHandle nh;

    // Check the buffer size (is 1 enough?)
    command_sub_ = nh.subscribe("/mobile_base/commands/velocity", 1, &DriveCommands::mapCommands, this);

  }
    void mapCommands(geometry_msgs::Twist &command) {
      ROS_INFO("mapCommands started");
      pitch = command.linear.x; // Take throttle into account!!!
      yaw = command.angular.z;

      // Map commands
      pitch = 200;  // dummy
      yaw = 125; // dummy
      // Generate PWM through GPIO

    }
protected:
  ros::Subscriber command_sub_;
};

int main(int argc, char **argv) {
  ros::init(argc, argv, ROS_PACKAGE_NAME);

  DriveCommands dc;

  ros::spin();

  return 0;
}
