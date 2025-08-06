def get_value_from_table(key, default=None):
    table = parent().op('logic_outputs') 
    if not table:
        return default
    key_lower = key.lower()
    for row in table.rows()[1:]:
        if row[0].val.lower() == key_lower:
            return row[1].val
    return default


def update_table(row_name, value):
    print(f"Updating row '{row_name}' with value: {value}")
    table = parent().op('logic_outputs')
    for row in table.rows()[1:]:
        print(f"Checking row: {row[0].val}")
        print(row[0].val)
        print(row_name)
        if row[0].val == row_name:
            row[1].val = value
            print(f"Updated row: {row_name} → {value}")
            break


def handle_controller_value_change(channel, value):
    if channel.name == 'R2Button':
        update_table('Animation Play', value)
        update_table('Audio Play', value)
        update_table('Scenery Movement On',value)
    if channel.name == 'R2Value':
        update_table('Animation Speed', value)
        update_table('Audio Speed', value)
        update_table('Scenery Movement Speed',value * 10)
    if channel.name == 'RJoystickX':
        camera_yaw = math.radians(value)
        update_table('Camera Yaw', camera_yaw)
    if channel.name == 'RJoystickY':
        camera_pitch = math.radians(value)
        update_table('Camera Pitch', camera_pitch)
    return


def handle_parameter_value_change(param_name, value):
    if param_name == 'Animationplay':
        update_table('Animation Play',int(value))
    if param_name == 'Animationspeed':
        update_table('Animation Speed', value)
    if param_name == 'Audioplay':
        update_table('Audio Play', int(value))
    if param_name == 'Audiospeed':
        update_table('Audio Speed', value)
    if param_name == 'Scenerymovementon':
        update_table('Scenery Movement On', int(value))
    if param_name == 'Scenerymovementspeed':
        update_table('Scenery Movement Speed', value)
    if param_name == 'Camerayaw':
        update_table('Camera Yaw', value)
    if param_name == 'Camerapitch':
        update_table('Camera Pitch', value)
    if param_name == 'Cameradistance':
        update_table('Camera Distance', value)
    return

