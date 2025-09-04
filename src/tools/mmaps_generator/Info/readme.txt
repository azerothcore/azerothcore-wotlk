Generator command line args

--config            [file.*]        The path the yaml config file
                                    Default: "mmaps-config.yaml"

--threads           [#]             Max number of threads used by the generator
                                    Default: 3

--offMeshInput      [file.*]        Path to file containing off mesh connections data.
                                    Format must be: (see offmesh_example.txt)
                                    "map_id tile_x,tile_y (start_x start_y start_z) (end_x end_y end_z) size  //optional comments"
                                    Single mesh connection per line.

--silent            []              Make us script friendly. Do not wait for user input
                                    on error or completion.

--tile              [#,#]           Build the specified tile
                                    seperate number with a comma ','
                                    must specify a map number (see below)
                                    if this option is not used, all tiles are built

                    [#]             Build only the map specified by #
                                    this command will build the map regardless of --skip* option settings
                                    if you do not specify a map number, builds all maps that pass the filters specified by --skip* options

examples:

movement_extractor
builds maps using the default settings (see above for defaults)

movement_extractor 0
builds all tiles of map 0

movement_extractor 0 --tile 34,46
builds only tile 34,46 of map 0 (this is the southern face of blackrock mountain)
