#!/usr/bin/python

import sys, getopt
import gphoto2 as gp

verbose = False

def parse_args(argv):
   try:
      opts, args = getopt.getopt(argv,"v",["verbose"])
   except getopt.GetoptError:
      print("Failed to parse args")
      sys.exit(2)
   for opt, arg in opts:
      if opt in ("-v", "--verbose"):
        verbose = True
    

def _recursive_get_properties(widget):
    count = widget.count_children()
    properties = {}
    # print(count)
    properties["name"] = widget.get_name()
    properties["label"] = widget.get_label()
    properties["type"] = widget.get_type()
    properties["children"] = []
    if count < 1:
        properties["value"] = widget.get_value()
    for child in widget.get_children():
        # print(child.get_label())
        # print(child.get_name())
        # print(child.get_type())
        child_prop = _recursive_get_properties(child)
        if child_prop is not None:
            properties["children"].append(child_prop) 
    return properties;


def get_camera_properties(camera):
    print(camera)
    name, addr = camera
    camera = gp.Camera()
    # search ports for camera port name
    port_info_list = gp.PortInfoList()
    port_info_list.load()
    idx = port_info_list.lookup_path(addr)
    camera.set_port_info(port_info_list[idx])
    camera.init()
    config = camera.get_config()
    print(_recursive_get_properties(config));

def get_connected_cameras():
    if verbose:
        print("Getting cameras")
    cameras = gp.Camera.autodetect()
    for n, camera in enumerate(cameras):
        get_camera_properties(camera)


if __name__ == "__main__":
   parse_args(sys.argv[1:])
   get_connected_cameras()