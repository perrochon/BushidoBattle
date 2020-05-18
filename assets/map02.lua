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
  nextobjectid = 6,
  properties = {
    ["Title"] = "Forest Hunt"
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
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 52, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 52, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 52, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 39, 39, 39, 39, 39, 39, 39, 46, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 39, 52, 39, 52, 39, 39, 46, 46, 46, 46, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 52, 52, 39, 39, 46, 46, 46, 46, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 52, 52, 46, 46, 46, 46, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 52, 52, 46, 46, 46, 46, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 52, 52, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39
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
        57, 54, 55, 54, 57, 57, 56, 57, 56, 57, 55, 56, 57, 56, 57, 56, 54, 54, 55, 56, 56, 56, 57, 56, 56, 55, 55, 54, 57, 54, 57, 55, 57, 54, 54, 54,
        55, 0, 0, 0, 78, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 77, 55, 55, 55, 56, 57, 54,
        56, 57, 54, 0, 55, 56, 57, 57, 54, 54, 0, 0, 0, 0, 0, 0, 0, 54, 54, 0, 54, 54, 54, 55, 56, 54, 54, 57, 54, 2684354638, 0, 0, 55, 56, 57, 54,
        56, 57, 0, 0, 0, 0, 56, 57, 57, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 0, 57, 57, 55, 56, 54, 54, 56, 57, 54, 2684354638, 54, 0, 55, 56, 57, 54,
        57, 0, 0, 0, 0, 0, 0, 56, 57, 54, 54, 54, 54, 54, 57, 55, 56, 54, 54, 0, 55, 55, 56, 57, 54, 55, 56, 57, 57, 2684354638, 54, 54, 0, 0, 0, 54,
        56, 0, 0, 0, 55, 56, 39, 0, 0, 57, 57, 57, 57, 54, 55, 54, 54, 57, 54, 0, 55, 55, 56, 57, 54, 55, 56, 55, 56, 2684354638, 57, 54, 0, 0, 0, 57,
        55, 0, 0, 55, 56, 54, 39, 0, 0, 0, 55, 56, 57, 54, 54, 54, 56, 0, 54, 0, 54, 0, 56, 54, 54, 54, 55, 55, 56, 2684354638, 57, 54, 54, 54, 0, 55,
        55, 0, 55, 56, 57, 54, 39, 56, 0, 0, 55, 56, 57, 54, 57, 55, 56, 57, 54, 0, 55, 56, 57, 54, 56, 57, 55, 0, 55, 2684354638, 57, 0, 57, 54, 0, 54,
        54, 0, 55, 56, 57, 54, 39, 56, 57, 0, 0, 0, 0, 54, 54, 54, 55, 56, 0, 0, 0, 0, 0, 0, 56, 57, 55, 56, 57, 2684354638, 55, 56, 57, 54, 54, 55,
        54, 0, 55, 56, 54, 54, 39, 56, 57, 55, 55, 0, 0, 54, 0, 0, 0, 0, 0, 1610612804, 69, 69, 68, 0, 0, 0, 0, 55, 56, 2684354638, 55, 56, 57, 57, 54, 56,
        56, 55, 56, 57, 54, 54, 39, 56, 57, 55, 55, 0, 0, 0, 0, 0, 0, 0, 0, 1610612805, 66, 0, 3221225540, 69, 69, 69, 0, 0, 39, 2684354638, 39, 39, 39, 39, 0, 54,
        54, 55, 55, 56, 57, 54, 0, 55, 54, 55, 56, 57, 0, 0, 0, 0, 0, 0, 0, 1610612805, 0, 0, 0, 0, 0, 0, 46, 46, 46, 46, 46, 46, 46, 46, 46, 56,
        55, 0, 39, 39, 39, 39, 39, 39, 0, 0, 55, 55, 57, 52, 0, 0, 0, 0, 39, 1610612805, 81, 46, 1610612804, 3221225541, 3221225541, 3221225541, 0, 0, 39, 39, 39, 39, 39, 39, 39, 57,
        56, 0, 55, 56, 57, 54, 56, 57, 54, 54, 55, 55, 0, 52, 0, 39, 0, 0, 39, 3221225540, 3221225541, 3221225541, 2684354628, 0, 0, 0, 0, 56, 57, 39, 55, 56, 57, 57, 0, 56,
        54, 0, 55, 56, 57, 54, 56, 57, 54, 57, 54, 0, 0, 52, 52, 39, 0, 0, 39, 39, 39, 0, 0, 0, 57, 57, 55, 39, 39, 39, 55, 56, 57, 0, 0, 57,
        56, 0, 0, 56, 54, 54, 56, 57, 54, 55, 55, 55, 56, 52, 52, 52, 52, 52, 0, 0, 0, 0, 54, 54, 54, 55, 39, 39, 54, 55, 56, 57, 54, 0, 0, 56,
        55, 55, 0, 54, 54, 55, 56, 57, 54, 55, 56, 57, 54, 52, 52, 52, 52, 52, 0, 0, 0, 0, 57, 57, 2684354625, 2684354625, 39, 57, 55, 55, 56, 57, 54, 54, 0, 54,
        55, 0, 0, 57, 54, 55, 56, 57, 54, 0, 0, 0, 0, 0, 54, 54, 54, 52, 0, 0, 57, 0, 0, 39, 76, 76, 76, 76, 76, 56, 57, 57, 57, 57, 0, 57,
        55, 0, 56, 57, 54, 54, 56, 54, 0, 0, 56, 57, 54, 54, 54, 57, 54, 0, 0, 0, 57, 54, 0, 55, 76, 76, 76, 76, 76, 55, 55, 55, 56, 57, 0, 55,
        54, 0, 55, 56, 57, 56, 54, 54, 54, 0, 56, 57, 57, 57, 56, 57, 54, 54, 0, 0, 0, 54, 54, 55, 76, 76, 76, 76, 76, 56, 57, 54, 0, 0, 0, 55,
        54, 0, 0, 55, 56, 57, 54, 57, 54, 0, 0, 0, 0, 55, 56, 57, 57, 57, 0, 0, 0, 57, 54, 54, 76, 76, 76, 76, 76, 56, 57, 0, 0, 0, 0, 56,
        56, 0, 0, 55, 56, 57, 54, 56, 57, 54, 54, 55, 55, 55, 55, 55, 55, 55, 55, 55, 0, 55, 56, 57, 54, 55, 56, 55, 56, 57, 54, 0, 0, 0, 0, 55,
        55, 0, 0, 55, 56, 57, 54, 55, 56, 57, 54, 55, 56, 57, 0, 0, 0, 0, 54, 54, 0, 54, 54, 57, 54, 54, 55, 55, 56, 57, 54, 0, 0, 0, 0, 55,
        56, 0, 0, 55, 56, 57, 54, 55, 55, 56, 55, 56, 57, 54, 0, 55, 55, 55, 55, 55, 0, 0, 55, 54, 54, 54, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55,
        54, 0, 0, 55, 56, 57, 54, 0, 55, 55, 55, 56, 57, 0, 0, 55, 56, 57, 0, 54, 55, 0, 0, 55, 55, 56, 0, 0, 0, 0, 56, 0, 0, 0, 0, 57,
        56, 0, 0, 55, 56, 57, 54, 0, 0, 55, 56, 57, 0, 0, 0, 0, 55, 56, 0, 0, 0, 0, 0, 55, 55, 55, 0, 0, 0, 0, 54, 54, 0, 0, 0, 54,
        56, 0, 0, 55, 56, 57, 54, 54, 0, 0, 0, 0, 0, 0, 0, 0, 55, 56, 57, 0, 54, 0, 0, 0, 0, 55, 56, 55, 56, 57, 57, 54, 54, 0, 0, 57,
        55, 0, 0, 55, 55, 56, 57, 54, 0, 0, 54, 54, 54, 54, 54, 0, 0, 55, 56, 57, 54, 0, 0, 0, 0, 55, 55, 56, 55, 56, 57, 57, 54, 54, 0, 54,
        54, 0, 0, 0, 55, 56, 57, 55, 55, 55, 55, 56, 54, 57, 0, 0, 0, 55, 56, 57, 54, 54, 54, 0, 0, 0, 55, 56, 57, 55, 56, 57, 57, 54, 0, 56,
        54, 0, 0, 0, 0, 55, 55, 56, 57, 55, 56, 57, 54, 0, 0, 0, 0, 55, 56, 57, 57, 57, 57, 0, 54, 54, 55, 56, 57, 54, 55, 56, 57, 54, 0, 56,
        57, 0, 0, 0, 0, 0, 0, 0, 0, 55, 55, 56, 57, 0, 54, 54, 54, 54, 0, 0, 0, 0, 0, 0, 0, 57, 55, 56, 57, 54, 55, 56, 57, 54, 0, 56,
        55, 0, 54, 0, 0, 2684354640, 2684354640, 0, 0, 0, 0, 55, 55, 0, 55, 56, 57, 0, 0, 54, 54, 54, 0, 0, 0, 56, 55, 55, 55, 55, 55, 56, 57, 0, 0, 54,
        56, 57, 54, 0, 0, 0, 0, 0, 0, 0, 80, 0, 0, 0, 0, 55, 55, 55, 55, 56, 57, 54, 54, 54, 0, 0, 57, 54, 55, 56, 57, 0, 0, 0, 0, 54,
        56, 57, 54, 54, 54, 0, 0, 80, 0, 0, 80, 0, 0, 0, 0, 0, 0, 0, 55, 55, 55, 55, 56, 57, 55, 0, 0, 54, 54, 0, 0, 0, 55, 56, 57, 54,
        55, 55, 56, 57, 54, 54, 0, 80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55, 56, 57, 55,
        54, 55, 55, 56, 57, 54, 55, 56, 56, 57, 56, 54, 56, 55, 54, 55, 57, 54, 57, 54, 54, 54, 54, 56, 55, 55, 56, 54, 56, 54, 54, 57, 54, 54, 55, 55
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
          x = 928.141,
          y = 129.692,
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
          x = 730.879,
          y = 2424.92,
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
          x = 732,
          y = 2936,
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
          x = 844,
          y = 3240,
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
          x = 3440.34,
          y = 723.284,
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
          x = 315.23,
          y = 3023.28,
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
          x = 1236.21,
          y = 3317.33,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 33,
          name = "Soldier",
          type = "3",
          shape = "rectangle",
          x = 2136.15,
          y = 1226.54,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 34,
          name = "Soldier",
          type = "3",
          shape = "rectangle",
          x = 2129.02,
          y = 1039.02,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 35,
          name = "Soldier",
          type = "3",
          shape = "rectangle",
          x = 1125.07,
          y = 2616.85,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 36,
          name = "Soldier",
          type = "3",
          shape = "rectangle",
          x = 1230.05,
          y = 2028.51,
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
          x = 134.109,
          y = 913.203,
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
          x = 218.092,
          y = 2621.65,
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
          x = 2323.83,
          y = 1736.77,
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
          name = "Soldier",
          type = "3",
          shape = "rectangle",
          x = 1826.44,
          y = 2525.01,
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
          name = "Soldier",
          type = "3",
          shape = "rectangle",
          x = 1724.97,
          y = 616.619,
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
          name = "Soldier",
          type = "3",
          shape = "rectangle",
          x = 2130.85,
          y = 632.229,
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
          name = "Soldier",
          type = "3",
          shape = "rectangle",
          x = 2720.15,
          y = 725.893,
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
          name = "Soldier",
          type = "3",
          shape = "rectangle",
          x = 3129.93,
          y = 725.893,
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