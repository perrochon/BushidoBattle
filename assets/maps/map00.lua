return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.4",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 22,
  height = 20,
  tilewidth = 100,
  tileheight = 100,
  nextlayerid = 5,
  nextobjectid = 112,
  properties = {
    ["Title"] = "Menagerie"
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
      tilecount = 27,
      tiles = {
        {
          id = 11,
          properties = {
            ["blocked"] = "true",
            ["cover"] = -2,
            ["description"] = "rock"
          },
          image = "../../tiled/tiles/Boulder_01.png",
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
          image = "../../tiled/tiles/Boulder_02.png",
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
          image = "../../tiled/tiles/Boulder_03.png",
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
          image = "../../tiled/tiles/Boulder_04.png",
          width = 100,
          height = 100
        },
        {
          id = 38,
          properties = {
            ["blocked"] = "false",
            ["description"] = "meadow"
          },
          image = "../../tiled/tiles/Floor_Grass.png",
          width = 100,
          height = 100
        },
        {
          id = 45,
          properties = {
            ["blocked"] = "false",
            ["description"] = "road"
          },
          image = "../../tiled/tiles/Floor_Rock.png",
          width = 100,
          height = 100
        },
        {
          id = 51,
          properties = {
            ["blocked"] = "false",
            ["description"] = "river"
          },
          image = "../../tiled/tiles/Floor_Water.png",
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
          image = "../../tiled/tiles/Tree_Crown_01.png",
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
          image = "../../tiled/tiles/Tree_Crown_02.png",
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
          image = "../../tiled/tiles/Tree_Crown_03.png",
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
          image = "../../tiled/tiles/Tree_Crown_04.png",
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
          image = "../../tiled/tiles/Black_Patch.png",
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
          image = "../../tiled/tiles/Building_I_01_4x6.png",
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
          image = "../../tiled/tiles/Building_Tower_3sq_5x5.png",
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
          image = "../../tiled/tiles/Building_Tower_Octagon_2sq_4x4.png",
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
          image = "../../tiled/tiles/Castle_Outer_Wall_Corner_In_Round_Thin_3x3_A.png",
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
          image = "../../tiled/tiles/Castle_Outer_Wall_Straight_Thin_3x3_A.png",
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
          image = "../../tiled/tiles/Dungeon_Corner_In_2x2_1-1_Round.png",
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
          image = "../../tiled/tiles/Dungeon_Corner_Out_2x2_1-1.png",
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
          image = "../../tiled/tiles/Dungeon_Straight_2x2_1-1.png",
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
          image = "../../tiled/tiles/Floor_Wheat.png",
          width = 100,
          height = 100
        },
        {
          id = 76,
          properties = {
            ["blocked"] = "false",
            ["description"] = "path"
          },
          image = "../../tiled/tiles/Path_Thin_2x2_A.png",
          width = 100,
          height = 100
        },
        {
          id = 77,
          properties = {
            ["blocked"] = "false",
            ["description"] = "path"
          },
          image = "../../tiled/tiles/Path_Thin_2x2_B.png",
          width = 100,
          height = 100
        },
        {
          id = 78,
          properties = {
            ["blocked"] = "false",
            ["description"] = "puddle"
          },
          image = "../../tiled/tiles/Puddle_2x2_A.png",
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
          image = "../../tiled/tiles/Roof_Thatched.png",
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
          image = "../../tiled/tiles/Well_With_Base_2x2.png",
          width = 100,
          height = 100
        },
        {
          id = 81,
          properties = {
            ["blocked"] = "false",
            ["description"] = "dungeon floor"
          },
          image = "../../tiled/tiles/Floor_Dungeon_2x2.png",
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
      width = 22,
      height = 20,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39,
        39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39
      }
    },
    {
      type = "tilelayer",
      id = 3,
      name = "Environment",
      x = 0,
      y = 0,
      width = 22,
      height = 20,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        1610612804, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 69, 68,
        1610612805, 0, 0, 2684354629, 0, 0, 2684354629, 0, 0, 2684354629, 0, 0, 1610612805, 0, 0, 1610612805, 0, 0, 1610612805, 0, 0, 2684354629,
        1610612805, 0, 0, 2684354629, 0, 0, 2684354629, 0, 0, 2684354629, 0, 0, 1610612805, 0, 0, 1610612805, 0, 0, 1610612805, 0, 0, 2684354629,
        1610612805, 0, 3221225541, 2684354628, 0, 3221225541, 2684354628, 0, 3221225541, 2684354628, 0, 3221225541, 3221225540, 3221225541, 0, 3221225540, 3221225541, 0, 3221225540, 3221225541, 0, 2684354629,
        1610612805, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354629,
        1610612805, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354629,
        1610612805, 0, 69, 68, 0, 69, 68, 0, 69, 68, 0, 0, 1610612804, 69, 0, 1610612804, 69, 0, 1610612804, 69, 0, 2684354629,
        1610612805, 0, 0, 2684354629, 0, 0, 2684354629, 0, 0, 2684354629, 0, 0, 1610612805, 0, 0, 1610612805, 0, 0, 1610612805, 0, 0, 2684354629,
        1610612805, 0, 0, 2684354629, 0, 0, 2684354629, 0, 0, 2684354629, 0, 0, 1610612805, 0, 0, 1610612805, 0, 0, 1610612805, 0, 0, 2684354629,
        3221225540, 69, 69, 69, 69, 69, 69, 69, 69, 2684354628, 0, 0, 3221225540, 69, 69, 69, 69, 69, 69, 69, 69, 2684354628,
        1610612804, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 68, 0, 0, 1610612804, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 68,
        1610612805, 0, 0, 2684354629, 0, 0, 2684354629, 0, 0, 2684354629, 0, 0, 1610612805, 0, 0, 1610612805, 0, 0, 1610612805, 0, 0, 2684354629,
        1610612805, 0, 0, 2684354629, 0, 0, 2684354629, 0, 0, 2684354629, 0, 0, 1610612805, 0, 0, 1610612805, 0, 0, 1610612805, 0, 0, 2684354629,
        1610612805, 0, 3221225541, 2684354628, 0, 3221225541, 2684354628, 0, 3221225541, 2684354628, 0, 0, 3221225540, 3221225541, 0, 3221225540, 3221225541, 0, 3221225540, 3221225541, 0, 2684354629,
        1610612805, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354629,
        1610612805, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2684354629,
        1610612805, 0, 69, 68, 0, 69, 68, 0, 69, 68, 69, 0, 1610612804, 69, 0, 1610612804, 69, 0, 1610612804, 69, 0, 2684354629,
        1610612805, 0, 0, 2684354629, 0, 0, 2684354629, 0, 0, 2684354629, 0, 0, 1610612805, 0, 0, 1610612805, 0, 0, 1610612805, 0, 0, 2684354629,
        1610612805, 0, 0, 2684354629, 0, 0, 2684354629, 0, 0, 2684354629, 0, 0, 1610612805, 0, 0, 1610612805, 0, 0, 1610612805, 0, 0, 2684354629,
        3221225540, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 3221225541, 2684354628
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
          id = 49,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 135.855,
          y = 341.082,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 50,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 407.564,
          y = 315.067,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 51,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 716.849,
          y = 323.738,
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
          x = 1029.02,
          y = 341.082,
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
          x = 1410.57,
          y = 332.41,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 54,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 1719.86,
          y = 320.848,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 55,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 148.432,
          y = 641.265,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 56,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 420.141,
          y = 615.25,
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
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 729.426,
          y = 623.921,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 58,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 1423.15,
          y = 632.593,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 59,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 1732.44,
          y = 621.031,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 60,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 145.541,
          y = 1346.55,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 61,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 417.25,
          y = 1320.54,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 62,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 726.535,
          y = 1329.21,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 63,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 1420.26,
          y = 1337.88,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 64,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 1729.55,
          y = 1326.32,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 65,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 133.979,
          y = 1647.17,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 66,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 405.688,
          y = 1621.15,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 67,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 714.973,
          y = 1629.82,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 68,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 1408.69,
          y = 1638.49,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 69,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 1717.98,
          y = 1626.93,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 70,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 1124.42,
          y = 1618.69,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 71,
          name = "Hero",
          type = "1",
          shape = "rectangle",
          x = 1057.93,
          y = 939.42,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place one. Make sure south-east tile is empty, too, for second hero"
          }
        },
        {
          id = 79,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 2024.81,
          y = 333.642,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 80,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 2037.39,
          y = 633.825,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 81,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 2034.5,
          y = 1339.11,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 82,
          name = "SoldierSentry",
          type = "103",
          shape = "rectangle",
          x = 2022.93,
          y = 1639.72,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 83,
          name = "Bear",
          type = "6",
          shape = "rectangle",
          x = 1367.22,
          y = 1170.66,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Few."
          }
        },
        {
          id = 84,
          name = "Eagle",
          type = "7",
          shape = "rectangle",
          x = 1670.72,
          y = 1176.44,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Few"
          }
        },
        {
          id = 85,
          name = "Wolf",
          type = "5",
          shape = "rectangle",
          x = 1974.23,
          y = 1179.33,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 86,
          name = "Troll 1",
          type = "16",
          shape = "rectangle",
          x = 1338.31,
          y = 1821.03,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 87,
          name = "Troll 2",
          type = "17",
          shape = "rectangle",
          x = 1641.82,
          y = 1826.81,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 88,
          name = "Troll 3",
          type = "18",
          shape = "rectangle",
          x = 1925.09,
          y = 1826.81,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 89,
          name = "Samurai",
          type = "4",
          shape = "rectangle",
          x = 1346.98,
          y = 832.47,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place one. This is the boss of the level"
          }
        },
        {
          id = 90,
          name = "Blue Samurai",
          type = "14",
          shape = "rectangle",
          x = 1621.58,
          y = 818.018,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place one. This is the boss of the level"
          }
        },
        {
          id = 91,
          name = "SamuraiGreen",
          type = "15",
          shape = "rectangle",
          x = 1910.63,
          y = 818.018,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place one. This is the boss of the level"
          }
        },
        {
          id = 92,
          name = "Peasant",
          type = "2",
          shape = "rectangle",
          x = 1017.46,
          y = 121.402,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 93,
          name = "PeasantBerserker",
          type = "202",
          shape = "rectangle",
          x = 1026.14,
          y = 1821.03,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place Many. Peasants are weak and melee only."
          }
        },
        {
          id = 96,
          name = "Barbarian 1",
          type = "8",
          shape = "rectangle",
          x = 121.402,
          y = 118.511,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Barbarians are melee only."
          }
        },
        {
          id = 97,
          name = "Barbarian 2",
          type = "9",
          shape = "rectangle",
          x = 439.359,
          y = 127.183,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Barbarians are melee only."
          }
        },
        {
          id = 98,
          name = "Barbarian 3",
          type = "10",
          shape = "rectangle",
          x = 771.769,
          y = 109.84,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Barbarians are melee only."
          }
        },
        {
          id = 99,
          name = "Barbarian 4",
          type = "11",
          shape = "rectangle",
          x = 1355.65,
          y = 118.511,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Barbarians are melee only."
          }
        },
        {
          id = 100,
          name = "Barbarian 5",
          type = "12",
          shape = "rectangle",
          x = 1633.14,
          y = 109.84,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Barbarians are melee only."
          }
        },
        {
          id = 101,
          name = "Barbarian 6",
          type = "13",
          shape = "rectangle",
          x = 1945.32,
          y = 127.183,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Barbarians are melee only."
          }
        },
        {
          id = 102,
          name = "Soldier",
          type = "3",
          shape = "rectangle",
          x = 1066.6,
          y = 656.148,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Soldiers are range and melee."
          }
        },
        {
          id = 103,
          name = "Assassin 1",
          type = "21",
          shape = "rectangle",
          x = 130.073,
          y = 1144.65,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Barbarians are melee only."
          }
        },
        {
          id = 104,
          name = "Assassin 2",
          type = "22",
          shape = "rectangle",
          x = 450.921,
          y = 1133.08,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Barbarians are melee only."
          }
        },
        {
          id = 105,
          name = "Assassin 3",
          type = "23",
          shape = "rectangle",
          x = 728.411,
          y = 1144.65,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Barbarians are melee only."
          }
        },
        {
          id = 106,
          name = "Ninja 1",
          type = "25",
          shape = "rectangle",
          x = 161.869,
          y = 1780.56,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Barbarians are melee only."
          }
        },
        {
          id = 107,
          name = "Ninja 2",
          type = "26",
          shape = "rectangle",
          x = 465.374,
          y = 1769,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Barbarians are melee only."
          }
        },
        {
          id = 108,
          name = "Ninja 3",
          type = "27",
          shape = "rectangle",
          x = 783.331,
          y = 1803.69,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Barbarians are melee only."
          }
        },
        {
          id = 109,
          name = "Archer 1",
          type = "19",
          shape = "rectangle",
          x = 182.103,
          y = 780.441,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Barbarians are melee only."
          }
        },
        {
          id = 110,
          name = "Archer 2",
          type = "20",
          shape = "rectangle",
          x = 485.608,
          y = 786.222,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Barbarians are melee only."
          }
        },
        {
          id = 111,
          name = "Archer 3",
          type = "21",
          shape = "rectangle",
          x = 783.331,
          y = 783.331,
          width = 50,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {
            ["Description"] = "Place many. Barbarians are melee only."
          }
        }
      }
    }
  }
}
