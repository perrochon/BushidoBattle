return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.4",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 36,
  height = 36,
  tilewidth = 100,
  tileheight = 100,
  nextlayerid = 4,
  nextobjectid = 1,
  properties = {
    ["Title"] = "Bushido Battle Level 2"
  },
  tilesets = {
    {
      name = "Bushido",
      firstgid = 1,
      tilewidth = 100,
      tileheight = 100,
      spacing = 0,
      margin = 0,
      columns = 0,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 1,
        height = 1
      },
      properties = {},
      terrains = {},
      tilecount = 26,
      tiles = {
        {
          id = 11,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -2,
            ["description"] = "rock"
          },
          image = "../tiled/tiles/Boulder_01.png",
          width = 100,
          height = 100
        },
        {
          id = 12,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -2,
            ["description"] = "rock"
          },
          image = "../tiled/tiles/Boulder_02.png",
          width = 100,
          height = 100
        },
        {
          id = 13,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -2,
            ["description"] = "rock"
          },
          image = "../tiled/tiles/Boulder_03.png",
          width = 100,
          height = 100
        },
        {
          id = 14,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -2,
            ["description"] = "rock"
          },
          image = "../tiled/tiles/Boulder_04.png",
          width = 100,
          height = 100
        },
        {
          id = 38,
          properties = {
            ["blocked"] = "false",
            ["description"] = "meadow"
          },
          image = "../tiled/tiles/Floor_Grass.png",
          width = 100,
          height = 100
        },
        {
          id = 45,
          properties = {
            ["blocked"] = "false",
            ["description"] = "road"
          },
          image = "../tiled/tiles/Floor_Rock.png",
          width = 100,
          height = 100
        },
        {
          id = 51,
          properties = {
            ["blocked"] = "false",
            ["description"] = "river"
          },
          image = "../tiled/tiles/Floor_Water.png",
          width = 100,
          height = 100
        },
        {
          id = 53,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -2,
            ["description"] = "tree"
          },
          image = "../tiled/tiles/Tree_Crown_01.png",
          width = 100,
          height = 100
        },
        {
          id = 54,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -2,
            ["description"] = "tree"
          },
          image = "../tiled/tiles/Tree_Crown_02.png",
          width = 100,
          height = 100
        },
        {
          id = 55,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -2,
            ["description"] = "tree"
          },
          image = "../tiled/tiles/Tree_Crown_03.png",
          width = 100,
          height = 100
        },
        {
          id = 56,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -2,
            ["description"] = "tree"
          },
          image = "../tiled/tiles/Tree_Crown_04.png",
          width = 100,
          height = 100
        },
        {
          id = 63,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -10,
            ["description"] = "darkness"
          },
          image = "../tiled/tiles/Black_Patch.png",
          width = 100,
          height = 100
        },
        {
          id = 64,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -4,
            ["description"] = "building"
          },
          image = "../tiled/tiles/Building_I_01_4x6.png",
          width = 100,
          height = 100
        },
        {
          id = 65,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -4,
            ["description"] = "building"
          },
          image = "../tiled/tiles/Building_Tower_3sq_5x5.png",
          width = 100,
          height = 100
        },
        {
          id = 66,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -4,
            ["description"] = "building"
          },
          image = "../tiled/tiles/Building_Tower_Octagon_2sq_4x4.png",
          width = 100,
          height = 100
        },
        {
          id = 67,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -10,
            ["description"] = "wall"
          },
          image = "../tiled/tiles/Castle_Outer_Wall_Corner_In_Round_Thin_3x3_A.png",
          width = 100,
          height = 100
        },
        {
          id = 68,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -10,
            ["description"] = "wall"
          },
          image = "../tiled/tiles/Castle_Outer_Wall_Straight_Thin_3x3_A.png",
          width = 100,
          height = 100
        },
        {
          id = 69,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -10,
            ["description"] = "wall"
          },
          image = "../tiled/tiles/Dungeon_Corner_In_2x2_1-1_Round.png",
          width = 100,
          height = 100
        },
        {
          id = 70,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -10,
            ["description"] = "wall"
          },
          image = "../tiled/tiles/Dungeon_Corner_Out_2x2_1-1.png",
          width = 100,
          height = 100
        },
        {
          id = 71,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -10,
            ["description"] = "wall"
          },
          image = "../tiled/tiles/Dungeon_Straight_2x2_1-1.png",
          width = 100,
          height = 100
        },
        {
          id = 75,
          properties = {
            ["blocked"] = "false",
            ["cover"] = -1,
            ["description"] = "corn field"
          },
          image = "../tiled/tiles/Floor_Wheat.png",
          width = 100,
          height = 100
        },
        {
          id = 76,
          properties = {
            ["blocked"] = "false",
            ["description"] = "path"
          },
          image = "../tiled/tiles/Path_Thin_2x2_A.png",
          width = 100,
          height = 100
        },
        {
          id = 77,
          properties = {
            ["blocked"] = "false",
            ["description"] = "path"
          },
          image = "../tiled/tiles/Path_Thin_2x2_B.png",
          width = 100,
          height = 100
        },
        {
          id = 78,
          properties = {
            ["blocked"] = "false",
            ["description"] = "puddle"
          },
          image = "../tiled/tiles/Puddle_2x2_A.png",
          width = 100,
          height = 100
        },
        {
          id = 79,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -4,
            ["description"] = "building"
          },
          image = "../tiled/tiles/Roof_Thatched.png",
          width = 100,
          height = 100
        },
        {
          id = 80,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -1,
            ["description"] = "well"
          },
          image = "../tiled/tiles/Well_With_Base_2x2.png",
          width = 100,
          height = 100
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 1,
      name = "Ground",
      x = 0,
      y = 0,
      width = 36,
      height = 36,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46
      }
    },
    {
      type = "tilelayer",
      id = 3,
      name = "Environment",
      x = 0,
      y = 0,
      width = 36,
      height = 36,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        64, 64, 64, 64, 64, 3221225542, 72, 1610612806, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 3221225542, 72, 1610612806, 3221225542, 72, 72, 72, 1610612806,
        64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354631, 71, 0, 0, 0, 2684354632,
        64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 1610612808, 0, 0, 0, 0, 0, 0, 2684354632,
        64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64, 64, 64, 64, 3221225542, 72, 72, 72, 72, 72, 72, 72, 72, 72, 72, 71, 0, 3221225543, 1610612807, 0, 0, 0, 2684354632,
        64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64, 64, 64, 3221225542, 71, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354632, 1610612808, 0, 0, 0, 2684354632,
        64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64, 64, 64, 2684354630, 1610612807, 0, 0, 0, 3221225543, 3221225544, 3221225544, 3221225544, 1610612807, 0, 3221225543, 3221225544, 3221225544, 70, 2684354630, 3221225544, 1610612807, 0, 2684354632,
        64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64, 64, 64, 64, 2684354630, 3221225544, 3221225544, 3221225544, 70, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632,
        64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632,
        64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632,
        64, 64, 64, 64, 64, 1610612808, 0, 2684354631, 72, 72, 1610612806, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632,
        64, 64, 64, 64, 64, 1610612808, 0, 0, 0, 0, 2684354631, 1610612806, 64, 64, 64, 64, 3221225542, 72, 72, 72, 72, 72, 72, 72, 72, 71, 0, 2684354631, 72, 1610612806, 64, 64, 64, 1610612808, 0, 2684354632,
        64, 64, 64, 64, 64, 1610612808, 0, 0, 0, 0, 0, 2684354631, 72, 72, 72, 72, 71, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354632, 64, 64, 64, 1610612808, 0, 2684354632,
        64, 64, 64, 64, 64, 1610612808, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 81, 0, 0, 3221225543, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 1610612807, 0, 2684354631, 72, 72, 72, 71, 0, 2684354632,
        64, 64, 64, 64, 64, 1610612808, 0, 0, 0, 0, 0, 3221225543, 3221225544, 3221225544, 3221225544, 3221225544, 1610612807, 0, 0, 0, 0, 2684354632, 64, 64, 64, 64, 64, 1610612808, 0, 0, 0, 0, 0, 0, 0, 2684354632,
        64, 64, 64, 64, 64, 2684354630, 1610612807, 0, 3221225543, 3221225544, 3221225544, 70, 64, 64, 64, 64, 2684354630, 3221225544, 1610612807, 0, 3221225543, 70, 64, 64, 64, 64, 64, 1610612808, 0, 3221225543, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 70,
        64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64,
        64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64,
        64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64,
        64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 3221225542, 72, 72, 72, 72, 72, 72, 72, 72, 71, 0, 2684354632, 64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64,
        64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354631, 71, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354632, 64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354631, 1610612806, 64, 64, 64, 64, 64,
        64, 64, 64, 64, 64, 64, 1610612808, 0, 3221225543, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 70, 64, 64, 64, 64, 3221225542, 72, 71, 0, 0, 2684354631, 72, 1610612806, 64, 64, 64,
        64, 64, 64, 64, 64, 3221225542, 71, 0, 2684354632, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 1610612808, 0, 0, 0, 0, 0, 0, 2684354632, 64, 64, 64,
        64, 64, 64, 64, 64, 1610612808, 0, 0, 2684354632, 64, 3221225542, 72, 72, 72, 72, 72, 72, 1610612806, 64, 64, 64, 64, 64, 64, 64, 1610612808, 0, 0, 0, 0, 0, 0, 2684354632, 64, 64, 64,
        64, 64, 64, 64, 64, 1610612808, 0, 0, 2684354632, 3221225542, 71, 0, 0, 0, 0, 0, 0, 2684354631, 1610612806, 64, 64, 64, 64, 64, 64, 1610612808, 0, 0, 0, 0, 0, 0, 2684354632, 64, 64, 64,
        64, 64, 64, 64, 64, 1610612808, 0, 0, 2684354632, 1610612808, 0, 0, 0, 0, 0, 0, 0, 0, 2684354632, 64, 64, 64, 64, 64, 64, 2684354630, 3221225544, 3221225544, 3221225544, 1610612807, 0, 3221225543, 70, 64, 64, 64,
        64, 64, 64, 64, 64, 1610612808, 0, 0, 2684354632, 1610612808, 0, 0, 0, 0, 0, 0, 0, 0, 2684354631, 72, 72, 72, 1610612806, 64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64,
        64, 64, 64, 64, 64, 1610612808, 0, 0, 2684354632, 2684354630, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 1610612807, 0, 0, 3221225543, 3221225544, 3221225544, 3221225544, 70, 64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64,
        64, 64, 64, 64, 64, 2684354630, 1610612807, 0, 2684354632, 64, 64, 64, 64, 64, 64, 1610612808, 0, 0, 2684354631, 72, 72, 72, 72, 72, 72, 1610612806, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64,
        64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64, 1610612808, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354632, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64,
        64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64, 64, 64, 1610612808, 0, 3221225543, 3221225544, 3221225544, 3221225544, 3221225544, 1610612807, 0, 3221225543, 70, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64,
        64, 64, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 3221225542, 72, 72, 72, 71, 0, 2684354632, 64, 64, 64, 3221225542, 71, 3221225543, 70, 64, 64, 64, 64, 1610612808, 0, 2684354632, 64, 64, 64, 64,
        64, 64, 64, 64, 64, 3221225542, 71, 0, 2684354631, 72, 72, 71, 0, 0, 0, 0, 0, 2684354632, 64, 64, 3221225542, 71, 3221225543, 70, 64, 64, 64, 64, 64, 1610612808, 0, 2684354631, 72, 72, 72, 1610612806,
        64, 64, 64, 64, 64, 1610612808, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354631, 72, 72, 71, 0, 2684354631, 72, 72, 72, 72, 72, 72, 71, 0, 0, 0, 0, 0, 2684354632,
        64, 64, 64, 64, 64, 2684354630, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 1610612807, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354632,
        64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 1610612808, 0, 0, 0, 0, 0, 3221225543, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 1610612807, 0, 0, 0, 0, 0, 2684354632,
        64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 2684354630, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 70, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 2684354630, 3221225544, 3221225544, 3221225544, 3221225544, 3221225544, 70
      }
    }
  }
}