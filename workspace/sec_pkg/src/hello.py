#!/usr/bin/env python
#
# hello.py
#
# Created on: Nov 17, 2016
#     Author: Dany Rovinsky 
#

import rospy

print(__name__)
if __name__ == "__main__":

    rospy.init_node("hello")

    rate = rospy.Rate(10)

    count = 0
    while not rospy.is_shutdown():
        rospy.loginfo("hello world %d" % count)
        rate.sleep()
        count += 1


