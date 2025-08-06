def reposition_camera(yaw, pitch, distance):
    radius = distance
    cam = parent().op('camMain')  # Your Camera COMP
    target_path = parent().par.Cameratarget  # Evaluate the path string
    target = op(target_path)  # Get the target COMP

    if not target or not cam:
        debug("Camera or target not found.")
        return

    cam.par.tx = target.par.tx + radius * math.cos(pitch) * math.cos(yaw)
    cam.par.tz = target.par.tz + radius * math.cos(pitch) * math.sin(yaw)
    cam.par.ty = target.par.ty + radius * math.sin(pitch)

def handle_table_change(table):
    yaw = float(table['Camera Yaw', 1])
    pitch = float(table['Camera Pitch', 1])
    distance = float(table['Camera Distance', 1])
    
    reposition_camera(yaw, pitch, distance)
    
    return
