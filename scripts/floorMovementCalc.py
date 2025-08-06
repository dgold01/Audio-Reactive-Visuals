def onValueChange(channel, sampleIndex, val, prev):
    # This runs at the start of every frame
    forward_speed = op('/base_scenery').par.Floormovementspeed.eval()
    t = val 
    print(t)
    new_tz = -(forward_speed * t)
    op('/base_scenery/instanced_geo_floor').par.tz = new_tz

    return