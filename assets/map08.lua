return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.4",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 30,
  height = 30,
  tilewidth = 100,
  tileheight = 100,
  nextlayerid = 4,
  nextobjectid = 58,
  properties = {
    ["Title"] = "Peasant Mob"
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
      width = 30,
      height = 30,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 52, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 52, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 52, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 52, 52, 52, 52, 52, 39, 39, 39, 52, 52, 52, 52, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 52, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 52, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 52, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 52, 52, 39, 39, 39, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 52, 39, 39, 39, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 52, 39, 39, 39, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 52, 52, 52, 52, 52, 52, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 39, 39, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 39, 39, 39, 52, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 39, 39, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 39, 39, 39, 52, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 39, 39, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 39, 39, 39, 52, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 39, 39, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 39, 39, 39, 52, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 39, 39, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 52, 52, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 39, 39, 39, 39, 39, 46, 39, 52, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 39, 39, 39, 39, 39, 46, 39, 52, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 39, 39, 39, 39, 39, 46, 39, 52, 52, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 39, 39, 39, 39, 39, 46, 39, 39, 52, 39, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 39, 39, 39, 39, 39, 46, 39, 39, 52, 39, 39, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 39, 39, 39, 39, 39, 46, 39, 39, 52, 52, 39, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 39, 39, 39, 39, 39, 46, 39, 39, 39, 52, 39, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 39, 39, 39, 52, 52, 52, 52, 52, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 52, 52, 52, 52, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 52, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 52, 46, 46, 46, 46, 46, 46, 46, 46,
        46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 46, 52, 46, 46, 46, 46, 46, 46, 46, 46
      }
    },
    {
      type = "tilelayer",
      id = 3,
      name = "Environment",
      x = 0,
      y = 0,
      width = 30,
      height = 30,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        1610612804, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 68, 12, 2684354629, 12, 2684354629,
        1610612805, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354629, 2684354638, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612804, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 0, 2684354629, 2684354638, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 13, 1610612749, 0, 0, 0, 0, 0, 0, 0, 0, 2684354629, 2684354638, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 0, 13, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 12, 0, 0, 0, 12, 0, 0, 0, 0, 0, 2684354629, 2684354638, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 0, 0, 0, 0, 0, 0, 2684354638, 0, 0, 0, 0, 0, 1610612805, 0, 12, 0, 14, 0, 12, 0, 14, 0, 2684354629, 2684354638, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 79, 79, 0, 79, 79, 79, 2684354638, 0, 0, 0, 0, 0, 3221225540, 0, 3221225541, 0, 3221225541, 0, 3221225541, 0, 3221225541, 0, 2684354629, 2684354638, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 0, 79, 0, 79, 79, 0, 3221225549, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 78, 2684354629, 2684354638, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 0, 79, 0, 79, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1610612814, 0, 0, 0, 0, 0, 0, 0, 2684354637, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 0, 0, 0, 0, 66, 0, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1610612814, 0, 0, 54, 0, 0, 1610612814, 0, 0, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1610612814, 0, 0, 15, 54, 67, 1610612814, 67, 54, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 0, 0, 0, 0, 15, 0, 66, 0, 0, 0, 66, 0, 0, 66, 0, 1610612814, 0, 0, 54, 13, 0, 1610612814, 0, 15, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 66, 0, 1610612814, 0, 0, 65, 39, 0, 1610612814, 39, 65, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 0, 0, 0, 0, 0, 54, 0, 66, 0, 0, 66, 0, 0, 66, 0, 1610612814, 0, 0, 65, 39, 0, 1610612814, 39, 65, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 0, 0, 81, 0, 0, 54, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1610612814, 0, 0, 65, 39, 81, 1610612814, 39, 65, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 0, 0, 0, 0, 0, 54, 0, 15, 0, 0, 0, 0, 0, 0, 0, 1610612814, 0, 0, 65, 39, 0, 1610612814, 39, 65, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 1610612813, 78, 78, 78, 78, 78, 78, 78, 78, 78, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 2684354637, 0, 79, 65, 39, 0, 1610612814, 39, 65, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 2684354638, 66, 2684354625, 2684354625, 2684354625, 2684354625, 2684354625, 66, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1610612814, 0, 0, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 2684354638, 3221225537, 0, 0, 0, 0, 0, 65, 54, 0, 0, 81, 0, 0, 66, 66, 66, 0, 0, 0, 0, 1610612814, 0, 0, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 2684354638, 3221225537, 0, 0, 0, 0, 0, 65, 54, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1610612814, 0, 79, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 2684354638, 3221225537, 0, 67, 0, 67, 0, 65, 54, 0, 0, 0, 0, 66, 66, 66, 0, 81, 0, 0, 0, 1610612814, 0, 0, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 2684354638, 3221225537, 0, 0, 0, 0, 0, 65, 54, 54, 0, 54, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1610612814, 0, 0, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 2684354638, 3221225537, 0, 67, 0, 67, 0, 65, 54, 54, 0, 54, 54, 0, 0, 0, 0, 0, 0, 0, 0, 1610612814, 0, 0, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 2684354638, 3221225537, 0, 0, 0, 0, 0, 65, 54, 54, 0, 0, 54, 1610612813, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 2684354637, 0, 0, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 2684354638, 3221225537, 0, 0, 0, 0, 0, 65, 54, 54, 54, 0, 54, 1610612814, 0, 0, 0, 0, 0, 66, 0, 0, 66, 0, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 2684354638, 66, 2684354625, 2684354625, 0, 2684354625, 2684354625, 66, 54, 54, 54, 0, 0, 1610612814, 0, 0, 0, 0, 0, 66, 0, 0, 66, 0, 2684354629, 0, 2684354629,
        1610612805, 0, 1610612805, 3221225549, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 3221225550, 2684354637, 0, 0, 0, 0, 0, 66, 0, 0, 66, 0, 2684354629, 0, 2684354629,
        1610612805, 0, 3221225540, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 2684354628, 0, 2684354629,
        1610612805, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354629,
        3221225540, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 2684354628
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
          id = 1,
          name = "Samurai",
          type = "4",
          shape = "rectangle",
          x = 724.653,
          y = 1930.58,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place one. This is the boss of the level"
          }
        },
        {
          id = 34,
          name = "PeasantBerserker",
          type = "202",
          shape = "rectangle",
          x = 2825.48,
          y = 337.228,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 35,
          name = "PeasantBerserker",
          type = "202",
          shape = "rectangle",
          x = 2827.89,
          y = 428.761,
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
          name = "PeasantBerserker",
          type = "202",
          shape = "rectangle",
          x = 2827.89,
          y = 529.929,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 37,
          name = "PeasantBerserker",
          type = "202",
          shape = "rectangle",
          x = 2827.89,
          y = 638.323,
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
          name = "PeasantBerserker",
          type = "202",
          shape = "rectangle",
          x = 2830.3,
          y = 753.944,
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
          name = "PeasantBerserker",
          type = "202",
          shape = "rectangle",
          x = 2842.35,
          y = 835.842,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 40,
          name = "PeasantBerserker",
          type = "202",
          shape = "rectangle",
          x = 2847.16,
          y = 929.784,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 41,
          name = "PeasantBerserker",
          type = "202",
          shape = "rectangle",
          x = 2830.3,
          y = 1023.73,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 44,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 1625.92,
          y = 621.458,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 45,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 2423.22,
          y = 631.096,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 46,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 2218.47,
          y = 628.69,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 47,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 2025.78,
          y = 621.457,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 48,
          name = "PeasantBerserker",
          type = "202",
          shape = "rectangle",
          x = 2825.48,
          y = 231.242,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 49,
          name = "PeasantBerserker",
          type = "202",
          shape = "rectangle",
          x = 2835.12,
          y = 130.073,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 50,
          name = "Hero",
          type = "1",
          shape = "rectangle",
          x = 2620.74,
          y = 139.709,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place one. Make sure south-east tile is empty, too, for second hero"
          }
        },
        {
          id = 51,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 1828.25,
          y = 616.645,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 52,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 2423.22,
          y = 1026.14,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 53,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 770.806,
          y = 2526.8,
          width = 50,
          height = 50,
          rotation = 90,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 54,
          name = "Peasant",
          type = "2",
          shape = "rectangle",
          x = 2129.35,
          y = 2033,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 55,
          name = "Peasant",
          type = "2",
          shape = "rectangle",
          x = 1425.99,
          y = 1030.95,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 56,
          name = "Soldier",
          type = "3",
          shape = "rectangle",
          x = 428.761,
          y = 1122.49,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 57,
          name = "Soldier",
          type = "3",
          shape = "rectangle",
          x = 1120.08,
          y = 924.967,
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
