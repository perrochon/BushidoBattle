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
  nextobjectid = 7,
  properties = {
    ["Title"] = "Prison"
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
        64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        64, 64, 64, 64, 64, 46, 46, 46, 46, 46, 46, 64, 64, 64, 64, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        64, 64, 64, 64, 64, 46, 46, 46, 46, 46, 46, 64, 64, 64, 64, 46, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        64, 64, 64, 64, 64, 46, 46, 46, 46, 46, 46, 64, 64, 64, 64, 46, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        64, 64, 64, 64, 64, 46, 46, 46, 46, 46, 46, 64, 64, 64, 64, 46, 46, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        64, 64, 64, 64, 64, 64, 64, 64, 46, 64, 64, 64, 64, 64, 64, 46, 46, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        64, 46, 46, 46, 46, 46, 46, 64, 46, 64, 64, 64, 46, 46, 46, 46, 46, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        64, 46, 46, 46, 46, 46, 46, 64, 46, 64, 64, 64, 46, 46, 46, 46, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        64, 46, 46, 46, 46, 46, 46, 46, 46, 64, 64, 64, 46, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        64, 46, 46, 46, 46, 46, 46, 64, 46, 46, 46, 46, 46, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        64, 46, 46, 46, 46, 46, 46, 64, 46, 64, 64, 64, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39,
        64, 46, 46, 46, 46, 46, 46, 64, 46, 64, 64, 64, 46, 46, 46, 39, 39, 39, 39, 39, 46, 39, 46, 39, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        64, 64, 64, 64, 64, 64, 64, 64, 46, 64, 64, 64, 64, 64, 64, 39, 39, 39, 39, 46, 46, 46, 46, 46, 46, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        64, 64, 64, 64, 64, 64, 64, 64, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 46, 64, 64, 64, 64, 39, 46, 39, 39, 46, 46, 46, 46, 46, 46, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        64, 64, 64, 46, 46, 64, 64, 64, 64, 64, 46, 64, 64, 64, 64, 39, 46, 39, 39, 46, 46, 46, 46, 46, 46, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        64, 64, 46, 46, 46, 46, 64, 64, 64, 64, 46, 64, 64, 64, 64, 39, 46, 39, 39, 46, 46, 46, 46, 46, 46, 39, 46, 46, 46, 46, 46, 46, 46, 46, 46, 39,
        64, 46, 46, 46, 46, 46, 64, 64, 64, 64, 46, 64, 64, 64, 64, 39, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 39,
        64, 46, 46, 46, 46, 46, 64, 64, 64, 64, 46, 64, 64, 64, 64, 39, 39, 39, 39, 46, 46, 46, 46, 46, 46, 39, 46, 46, 46, 46, 46, 46, 46, 46, 46, 39,
        64, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 64, 64, 64, 64, 39, 39, 39, 39, 46, 46, 46, 46, 46, 46, 39, 46, 39, 39, 39, 39, 39, 39, 52, 39, 39,
        64, 46, 46, 46, 46, 46, 64, 64, 46, 64, 64, 64, 64, 64, 64, 39, 39, 39, 39, 46, 46, 46, 46, 46, 46, 39, 46, 39, 39, 39, 39, 39, 52, 52, 39, 39,
        64, 46, 46, 46, 46, 46, 64, 64, 46, 64, 64, 64, 64, 64, 64, 39, 39, 39, 39, 46, 46, 46, 46, 46, 46, 39, 46, 39, 39, 39, 39, 39, 52, 52, 39, 39,
        64, 64, 46, 46, 46, 46, 64, 64, 46, 64, 64, 64, 64, 64, 64, 39, 39, 39, 39, 46, 46, 46, 46, 46, 46, 39, 46, 39, 39, 39, 39, 39, 52, 52, 39, 39,
        64, 64, 64, 46, 46, 64, 64, 64, 46, 64, 64, 64, 64, 64, 64, 39, 39, 39, 39, 46, 46, 46, 46, 46, 46, 39, 46, 39, 39, 39, 39, 52, 52, 52, 39, 39,
        64, 64, 64, 64, 64, 64, 64, 64, 46, 64, 64, 64, 64, 64, 64, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 39, 39, 39, 52, 52, 52, 39, 39,
        64, 64, 64, 64, 64, 64, 64, 64, 46, 64, 64, 64, 64, 64, 64, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 39, 39,
        64, 64, 64, 64, 64, 46, 46, 46, 46, 46, 46, 46, 64, 64, 64, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 39, 39,
        64, 64, 64, 64, 64, 46, 46, 46, 46, 46, 46, 46, 64, 64, 64, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 39, 39,
        64, 64, 64, 64, 64, 46, 46, 46, 46, 46, 46, 46, 64, 64, 64, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 39, 39,
        64, 64, 64, 64, 64, 46, 46, 46, 46, 46, 46, 46, 64, 64, 64, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 39, 39,
        64, 64, 64, 64, 64, 46, 46, 46, 46, 46, 46, 46, 64, 64, 64, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 39, 39,
        64, 64, 64, 64, 64, 64, 64, 64, 46, 64, 64, 64, 64, 64, 64, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 52, 39,
        64, 64, 64, 64, 64, 64, 64, 64, 46, 64, 64, 64, 64, 64, 64, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 52, 39,
        64, 64, 64, 64, 64, 64, 64, 64, 46, 46, 46, 46, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 39,
        64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 39,
        64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 46, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39
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
        64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 15, 15, 15, 55, 56, 56, 56, 57, 56, 56, 55, 55, 54, 57, 54, 57, 55, 57, 54, 54, 54,
        64, 64, 64, 64, 64, 3221225542, 72, 72, 72, 72, 1610612806, 64, 64, 64, 64, 12, 13, 14, 0, 0, 0, 0, 55, 56, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 54,
        64, 64, 64, 64, 64, 1610612808, 0, 0, 0, 0, 2684354632, 64, 64, 64, 64, 12, 2684354572, 2684354572, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 54,
        64, 64, 64, 64, 64, 1610612808, 0, 0, 0, 0, 2684354632, 64, 64, 64, 64, 12, 2684354573, 2684354573, 14, 0, 0, 0, 57, 0, 0, 0, 55, 0, 56, 0, 0, 0, 54, 0, 0, 54,
        64, 64, 64, 64, 64, 2684354630, 3221225544, 3221225544, 0, 3221225544, 70, 64, 64, 64, 64, 12, 13, 14, 15, 14, 0, 0, 0, 0, 56, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 54,
        64, 64, 64, 64, 64, 64, 64, 64, 0, 64, 64, 64, 64, 64, 64, 1610612750, 2684354575, 2684354575, 13, 14, 0, 2684354615, 0, 0, 0, 0, 79, 55, 56, 57, 0, 0, 54, 54, 0, 57,
        64, 3221225542, 72, 72, 72, 72, 1610612806, 64, 0, 64, 64, 64, 3221225542, 72, 1610612806, 12, 13, 14, 15, 14, 0, 2684354615, 0, 56, 0, 0, 0, 0, 0, 0, 55, 0, 0, 0, 0, 55,
        64, 1610612808, 0, 0, 0, 0, 2684354632, 64, 0, 64, 64, 64, 1610612808, 0, 2684354632, 1610612748, 15, 15, 15, 0, 0, 2684354616, 0, 0, 0, 56, 0, 57, 0, 0, 0, 0, 0, 0, 0, 54,
        64, 1610612808, 0, 0, 0, 0, 0, 0, 0, 64, 64, 64, 1610612808, 0, 2684354632, 12, 0, 0, 0, 0, 0, 2684354617, 0, 0, 0, 0, 0, 0, 0, 57, 0, 0, 0, 0, 0, 55,
        64, 1610612808, 0, 0, 0, 0, 2684354632, 64, 0, 0, 0, 0, 0, 0, 2684354632, 12, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 68, 0, 0, 0, 0, 0, 0, 56,
        64, 1610612808, 0, 0, 0, 0, 2684354632, 64, 0, 64, 64, 64, 1610612808, 0, 2684354632, 66, 0, 0, 0, 67, 0, 67, 0, 67, 0, 0, 0, 66, 2684354629, 54, 0, 79, 54, 0, 0, 54,
        64, 2684354630, 3221225544, 3221225544, 3221225544, 3221225544, 70, 64, 0, 64, 64, 64, 2684354630, 3221225544, 70, 0, 0, 0, 0, 0, 0, 0, 79, 0, 0, 0, 0, 0, 2684354629, 57, 0, 0, 0, 0, 0, 56,
        64, 64, 64, 64, 64, 64, 64, 64, 0, 64, 64, 64, 64, 64, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354629, 55, 0, 2684354615, 79, 79, 0, 57,
        64, 64, 64, 64, 64, 64, 64, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354629, 57, 0, 2684354616, 79, 0, 0, 56,
        64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 0, 64, 64, 64, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354629, 54, 0, 2684354617, 0, 0, 0, 57,
        64, 64, 64, 3221225542, 1610612806, 64, 64, 64, 64, 64, 0, 64, 64, 64, 64, 0, 0, 0, 79, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354629, 57, 0, 0, 0, 0, 0, 56,
        64, 64, 3221225542, 71, 2684354631, 1610612806, 64, 64, 64, 64, 0, 64, 64, 64, 64, 0, 0, 0, 0, 0, 0, 81, 81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 54,
        64, 3221225542, 71, 0, 0, 2684354632, 64, 64, 64, 64, 0, 64, 64, 64, 64, 0, 0, 0, 0, 0, 0, 81, 81, 0, 79, 0, 0, 2684354625, 2684354629, 0, 0, 0, 0, 0, 0, 57,
        64, 1610612808, 0, 0, 0, 2684354632, 64, 64, 64, 64, 0, 64, 64, 64, 64, 0, 0, 0, 0, 0, 0, 81, 81, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55,
        64, 1610612808, 0, 0, 0, 0, 0, 0, 0, 0, 0, 64, 64, 64, 64, 0, 0, 0, 0, 79, 0, 0, 0, 0, 0, 0, 0, 0, 2684354629, 56, 2684354638, 0, 0, 0, 0, 55,
        64, 1610612808, 0, 0, 0, 2684354632, 64, 64, 0, 64, 64, 64, 64, 64, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354629, 57, 2684354638, 0, 0, 0, 0, 56,
        64, 2684354630, 1610612807, 0, 0, 2684354632, 64, 64, 0, 64, 64, 64, 64, 64, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354629, 54, 2684354638, 0, 0, 0, 0, 55,
        64, 64, 2684354630, 1610612807, 3221225543, 70, 64, 64, 0, 64, 64, 64, 64, 64, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354629, 56, 2684354638, 0, 0, 0, 0, 55,
        64, 64, 64, 2684354630, 70, 64, 64, 64, 0, 64, 64, 64, 64, 64, 64, 0, 0, 0, 0, 2684354625, 2684354625, 2684354625, 2684354625, 2684354625, 2684354625, 0, 0, 0, 2684354629, 55, 2684354638, 0, 0, 0, 0, 55,
        64, 64, 64, 64, 64, 64, 64, 64, 0, 64, 64, 64, 64, 64, 64, 66, 0, 0, 0, 2684354625, 2684354625, 2684354625, 2684354625, 2684354625, 2684354625, 0, 0, 66, 2684354629, 56, 2684354638, 0, 0, 0, 0, 57,
        64, 64, 64, 64, 64, 64, 64, 64, 0, 64, 64, 64, 64, 64, 64, 12, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 2684354628, 0, 2684354638, 0, 0, 0, 0, 54,
        64, 64, 64, 64, 64, 3221225542, 72, 72, 0, 72, 72, 1610612806, 64, 64, 64, 1610612751, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 79, 1610612813, 78, 2684354637, 0, 0, 0, 0, 57,
        64, 64, 64, 64, 64, 1610612808, 0, 0, 0, 0, 0, 2684354632, 64, 64, 64, 1610612750, 56, 13, 0, 55, 13, 55, 55, 57, 57, 57, 0, 0, 2684354638, 0, 0, 0, 0, 0, 0, 54,
        64, 64, 64, 64, 64, 1610612808, 0, 0, 0, 0, 0, 2684354632, 64, 64, 64, 1610612749, 2684354572, 56, 0, 55, 76, 76, 76, 76, 57, 80, 1610612814, 80, 2684354638, 80, 79, 0, 0, 0, 0, 56,
        64, 64, 64, 64, 64, 1610612808, 0, 0, 0, 0, 0, 2684354632, 64, 64, 64, 1610612748, 2684354573, 13, 0, 55, 76, 76, 76, 76, 78, 78, 78, 78, 2684354638, 78, 81, 0, 0, 0, 0, 56,
        64, 64, 64, 64, 64, 2684354630, 3221225544, 3221225544, 0, 3221225544, 3221225544, 70, 64, 64, 64, 2684354574, 2684354574, 13, 0, 13, 76, 76, 76, 76, 0, 80, 2684354638, 80, 2684354638, 80, 0, 0, 0, 0, 0, 56,
        64, 64, 64, 64, 64, 64, 64, 64, 0, 64, 64, 64, 64, 64, 64, 2684354575, 2684354575, 13, 0, 55, 76, 76, 76, 76, 3221225550, 3221225550, 78, 3221225550, 2684354638, 78, 81, 0, 0, 0, 0, 54,
        64, 64, 64, 64, 64, 64, 64, 64, 0, 64, 64, 64, 64, 64, 64, 12, 12, 0, 0, 55, 76, 76, 76, 76, 0, 80, 2684354638, 80, 2684354638, 80, 0, 0, 0, 0, 0, 54,
        64, 64, 64, 64, 64, 64, 64, 64, 0, 0, 0, 0, 0, 0, 0, 78, 78, 78, 0, 55, 76, 76, 76, 76, 57, 57, 79, 57, 57, 57, 57, 0, 0, 0, 0, 54,
        64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 12, 0, 0, 55, 55, 76, 76, 76, 76, 57, 57, 57, 0, 0, 0, 0, 0, 0, 0, 0, 55,
        64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 13, 14, 13, 14, 54, 54, 54, 54, 56, 55, 55, 56, 54, 56, 54, 54, 57, 54, 54, 55, 55
      }
    },
    {
      type = "objectgroup",
      id = 4,
      name = "Monsters",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 26,
          name = "Hero",
          type = "1",
          shape = "rectangle",
          x = 3417.67,
          y = 126.206,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place one. Make sure south-east tile is empty, too, for second hero"
          }
        },
        {
          id = 27,
          name = "Samurai",
          type = "4",
          shape = "rectangle",
          x = 1323.77,
          y = 737.051,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place one. This is the boss of the level"
          }
        },
        {
          id = 28,
          name = "Peasant",
          type = "2",
          shape = "rectangle",
          x = 3006.41,
          y = 2720.61,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 29,
          name = "Peasant",
          type = "2",
          shape = "rectangle",
          x = 2121.76,
          y = 3422.54,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 30,
          name = "Peasant",
          type = "2",
          shape = "rectangle",
          x = 3017.02,
          y = 726.326,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 31,
          name = "Peasant",
          type = "2",
          shape = "rectangle",
          x = 1934.77,
          y = 118.952,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 32,
          name = "Peasant",
          type = "2",
          shape = "rectangle",
          x = 2628.9,
          y = 2729.84,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 36,
          name = "Soldier",
          type = "3",
          shape = "rectangle",
          x = 2927.56,
          y = 3424.5,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 37,
          name = "Peasant",
          type = "2",
          shape = "rectangle",
          x = 2014.33,
          y = 820.152,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 38,
          name = "Peasant",
          type = "2",
          shape = "rectangle",
          x = 3221.49,
          y = 1540.98,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 39,
          name = "Peasant",
          type = "2",
          shape = "rectangle",
          x = 1821.4,
          y = 2632.59,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 1,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 933.638,
          y = 927.857,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 2,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 1029.03,
          y = 939.419,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 3,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 1422.14,
          y = 1332.53,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 4,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 1439.48,
          y = 3335.66,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 5,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 2838.49,
          y = 1636.04,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 6,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 2832.71,
          y = 1841.26,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        }
      }
    }
  }
}
