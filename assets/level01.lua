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
    ["Title"] = "Bushido Battle Level 1"
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
            ["cover"] = 2,
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
            ["cover"] = 2,
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
            ["cover"] = 2,
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
            ["cover"] = 2,
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
            ["description"] = "grass"
          },
          image = "../tiled/tiles/Floor_Grass.png",
          width = 100,
          height = 100
        },
        {
          id = 45,
          properties = {
            ["blocked"] = "false",
            ["description"] = "rocks"
          },
          image = "../tiled/tiles/Floor_Rock.png",
          width = 100,
          height = 100
        },
        {
          id = 51,
          properties = {
            ["blocked"] = "true",
            ["description"] = "water"
          },
          image = "../tiled/tiles/Floor_Water.png",
          width = 100,
          height = 100
        },
        {
          id = 53,
          properties = {
            ["blocked"] = "true",
            ["cover"] = 2,
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
            ["cover"] = 2,
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
            ["cover"] = 2,
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
            ["cover"] = 2,
            ["description"] = "tree"
          },
          image = "../tiled/tiles/Tree_Crown_04.png",
          width = 100,
          height = 100
        },
        {
          id = 63,
          properties = {
            ["blocked"] = "false",
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
            ["cover"] = 4,
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
            ["cover"] = 4,
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
            ["cover"] = 4,
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
            ["cover"] = 6,
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
            ["cover"] = 6,
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
            ["description"] = "wall"
          },
          image = "../tiled/tiles/Dungeon_Straight_2x2_1-1.png",
          width = 100,
          height = 100
        },
        {
          id = 75,
          properties = {
            ["blocked"] = "true",
            ["cover"] = 1,
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
            ["description"] = "road"
          },
          image = "../tiled/tiles/Path_Thin_2x2_A.png",
          width = 100,
          height = 100
        },
        {
          id = 77,
          properties = {
            ["blocked"] = "false",
            ["description"] = "road"
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
            ["cover"] = 4,
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
            ["cover"] = 1,
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
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 39, 39, 39, 39, 46, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        52, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 52, 52, 52, 52, 52, 52, 52, 39, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 52, 39, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 46, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 52, 52, 52, 52, 39, 39, 39, 39, 52, 52, 52, 52, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 39, 39, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 52, 52, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 52, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52,
        39, 39, 39, 76, 76, 76, 76, 39, 39, 39, 39, 39, 39, 39, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 76, 76, 76, 76, 39, 39, 39, 39, 39, 39, 39, 39, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 46, 39,
        39, 39, 39, 76, 76, 76, 76, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 46, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 46, 46, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39
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
        14, 15, 14, 14, 12, 12, 14, 12, 13, 13, 14, 13, 15, 15, 13, 14, 13, 13, 12, 13, 14, 12, 12, 12, 12, 14, 14, 15, 12, 15, 14, 14, 12, 15, 12, 13,
        13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 0, 0, 0, 0, 67, 0, 67, 0, 55, 0, 0, 0, 0, 0, 0, 55, 0, 0, 0, 0, 0, 0, 0, 12,
        14, 0, 0, 0, 0, 0, 0, 0, 15, 0, 0, 0, 0, 0, 54, 56, 55, 0, 0, 0, 54, 0, 0, 0, 0, 56, 0, 0, 54, 0, 0, 0, 0, 0, 0, 12,
        14, 0, 0, 54, 54, 0, 0, 0, 0, 0, 0, 0, 0, 0, 57, 54, 57, 0, 0, 0, 0, 0, 0, 55, 0, 0, 0, 0, 0, 0, 54, 0, 0, 0, 0, 12,
        13, 0, 0, 57, 56, 0, 0, 0, 0, 0, 0, 0, 0, 0, 57, 55, 54, 0, 0, 0, 0, 0, 57, 0, 0, 0, 0, 0, 56, 0, 0, 0, 0, 0, 0, 14,
        14, 0, 54, 56, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 57, 55, 54, 0, 0, 0, 57, 0, 0, 0, 0, 0, 54, 0, 0, 0, 54, 0, 0, 0, 56, 15,
        14, 0, 57, 54, 54, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15,
        15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 79, 0, 0, 0, 0, 0, 0, 57, 54, 0, 0, 57, 0, 0, 0, 56, 0, 0, 0, 0, 0, 13,
        12, 0, 0, 0, 0, 0, 0, 56, 57, 55, 55, 56, 55, 0, 0, 13, 12, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55, 0, 12,
        14, 0, 0, 0, 0, 0, 0, 54, 57, 13, 12, 57, 54, 0, 0, 14, 12, 0, 0, 0, 0, 54, 0, 0, 56, 0, 54, 0, 54, 0, 0, 0, 0, 57, 0, 14,
        14, 0, 14, 0, 0, 15, 0, 56, 54, 14, 12, 57, 57, 0, 0, 13, 14, 0, 0, 57, 0, 0, 0, 0, 0, 0, 0, 57, 0, 0, 0, 0, 0, 0, 0, 13,
        15, 0, 13, 15, 15, 0, 0, 56, 54, 54, 57, 56, 57, 0, 0, 12, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55, 0, 0, 0, 0, 14,
        12, 67, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 0, 67, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67, 14,
        14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 79, 0, 0, 0, 0, 0, 0, 12,
        14, 67, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67, 0, 0, 0, 0, 56, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67, 12,
        15, 0, 0, 0, 55, 54, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 54, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14,
        14, 0, 0, 0, 55, 55, 56, 0, 15, 0, 0, 0, 0, 0, 0, 54, 55, 0, 0, 0, 0, 0, 0, 13, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0, 14,
        14, 0, 0, 0, 55, 56, 55, 0, 0, 13, 14, 0, 0, 0, 54, 54, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 12, 12, 15, 14, 12, 0, 0, 0, 0, 15,
        14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14,
        15, 0, 0, 57, 55, 57, 54, 55, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13,
        13, 0, 57, 54, 57, 55, 57, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 12, 13, 13, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 13,
        13, 0, 56, 54, 57, 57, 54, 54, 55, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 56, 55, 13, 15, 13, 0, 0, 79, 0, 0, 0, 0, 0, 0, 12, 56,
        12, 0, 0, 0, 0, 0, 54, 54, 55, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 56, 13, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 55,
        15, 0, 57, 54, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 54, 0, 0, 15, 56,
        14, 0, 56, 57, 56, 55, 57, 55, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 56, 0, 0, 15, 13,
        13, 0, 57, 54, 57, 54, 55, 56, 56, 0, 0, 0, 79, 0, 0, 0, 0, 55, 0, 0, 0, 0, 0, 79, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15,
        14, 0, 0, 56, 57, 57, 54, 54, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13,
        12, 0, 0, 0, 54, 57, 56, 0, 0, 0, 0, 0, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14,
        14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1610612813, 78, 0, 0, 14, 0, 0, 0, 0, 56, 0, 0, 0, 0, 0, 0, 0, 0, 14, 12, 13, 14, 0, 0, 0, 13,
        15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354638, 0, 13, 0, 0, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 0, 0, 0, 0, 0, 0, 14,
        13, 0, 0, 0, 0, 0, 0, 0, 65, 81, 2684354638, 0, 0, 12, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 54, 0, 0, 0, 14, 0, 0, 1610612804, 69, 69, 69, 12,
        13, 0, 0, 0, 0, 0, 0, 78, 78, 78, 2684354637, 0, 0, 0, 12, 0, 0, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 1610612805, 80, 0, 0, 14,
        12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 14, 0, 0, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 1610612805, 80, 0, 0, 15,
        13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 0, 0, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67, 1610612805, 0, 0, 0, 13,
        14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 67, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15,
        15, 15, 15, 12, 14, 12, 14, 13, 14, 12, 14, 14, 15, 13, 14, 13, 14, 14, 14, 15, 14, 13, 12, 13, 14, 15, 14, 14, 14, 13, 14, 14, 14, 12, 15, 13
      }
    }
  }
}
