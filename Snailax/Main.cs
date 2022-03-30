using GmmlPatcher;
using UndertaleModLib;
using UndertaleModLib.Models;
using System;
using System.IO;
using System.Reflection;

namespace Snailax
{
    public static class GameMakerMod
    {

        public static Dictionary<string,string> GMLkvp = new Dictionary<string,string>();


        public static bool LoadGMLFolder(string gmlfolder)
        {


            try
            {
                string[] infos = Directory.GetFiles(gmlfolder);

                for (int i = 0; i < infos.Length; i++)
                {
                    FileInfo fo = new FileInfo(infos[i]);
                    //fo.Name
                    if (fo.Extension == ".gml")
                    {
                        Console.WriteLine("Reading File: " + fo.Name);
                        GMLkvp.Add(Path.GetFileNameWithoutExtension(fo.Name), File.ReadAllText(infos[i]));
                    }
                }
            }
            catch
            {
                Logger.Log("Failed to read/open: " + gmlfolder, Logger.LogLevel.Error);
                Logger.Log("Expect strange behavior or future crashes!", Logger.LogLevel.Error);
                Console.ResetColor();
                return false;
            }

            return true;
        }

        public static void CreateScriptFromKVP(UndertaleData data, string name, string key, ushort arguments)
        {
            data.CreateScript(name, GMLkvp[key], arguments);
        }

        public static void Load(UndertaleData data, IEnumerable<ModMetadata> queuedMods)
        {

            //supress vs being stupid
            #pragma warning disable CS8604
            string gmlfolder = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location),"GMLSource");
            #pragma warning restore CS8604

            LoadGMLFolder(gmlfolder);

            LoadGMLFolder(Path.Combine(gmlfolder,"Scripts"));

            LoadGMLFolder(Path.Combine(gmlfolder, "LevelEditorObjects"));

            LoadGMLFolder(Path.Combine(gmlfolder, "CreationCode"));

            // create playerspawn before everything else
            UndertaleGameObject playerspawn_object = new UndertaleGameObject();

            playerspawn_object.Name = data.CreateAndSaveString("obj_playerspawn");

            playerspawn_object.Sprite = data.Sprites.ByName("spr_player");

            data.GameObjects.Add(playerspawn_object);

            CreateScriptFromKVP(data, "scr_get_item_sprite_index", "gml_GlobalScript_scr_get_item_sprite_index",1);

            CreateScriptFromKVP(data, "scr_getitemoffsets",  "gml_GlobalScript_scr_getitemoffsets", 1);

            CreateScriptFromKVP(data, "scr_rotate_object", "gml_GlobalScript_scr_rotate_object", 3);

            try
            {

                data.Code.First(code => code.Name.Content == "gml_Object_obj_epilepsy_warning_Create_0")
                    .AppendGML("txt_1 = \"Snailax works lol\"", data);
            }
            // UndertaleModLib is trying to write profile cache but fails, we don't care
            catch (Exception) { /* ignored */ }

            //Create the level editor object
            UndertaleGameObject level_editor_object = new UndertaleGameObject();

            level_editor_object.Name = data.CreateAndSaveString("obj_level_editor");

            level_editor_object.Sprite = data.Sprites.ByName("spr_wall_original");

            level_editor_object.EventHandlerFor(EventType.Create, data.Strings, data.Code, data.CodeLocals)
                .AppendGMLSafe(GMLkvp["gml_Object_obj_level_editor_Create_0"], data);

            level_editor_object.EventHandlerFor(EventType.Step, EventSubtypeStep.Step, data.Strings, data.Code, data.CodeLocals)
                .AppendGMLSafe(GMLkvp["gml_Object_obj_level_editor_Step_0"], data);

            level_editor_object.EventHandlerFor(EventType.Draw, EventSubtypeDraw.Draw, data.Strings, data.Code, data.CodeLocals)
                .AppendGMLSafe(GMLkvp["gml_Object_obj_level_editor_Draw_0"], data);

            level_editor_object.EventHandlerFor(EventType.Draw, EventSubtypeDraw.DrawGUI, data.Strings, data.Code, data.CodeLocals)
                .AppendGMLSafe(GMLkvp["gml_Object_obj_level_editor_Draw_64"], data);

            data.GameObjects.Add(level_editor_object);

            UndertaleGameObject stupid_levelstyler = new UndertaleGameObject();

            stupid_levelstyler.Name = data.CreateAndSaveString("obj_i_hate_levelstylers");

            stupid_levelstyler.ParentId = data.GameObjects.ByName("obj_levelstyler");

            stupid_levelstyler.EventHandlerFor(EventType.Create, data.Strings, data.Code, data.CodeLocals)
                .AppendGMLSafe(GMLkvp["gml_Object_obj_i_hate_levelstylers_Create_0"], data);

            data.GameObjects.Add(stupid_levelstyler);

            Logger.Log("Created all objects!");


            // copy the room of funny and create the editor room
            UndertaleRoom copyme_room = data.Rooms.First(room => room.Name.Content == "level_basic_copy_me");

            if (copyme_room == null)
            {
                throw new NullReferenceException("Unable to find: level_basic_copy_me!");
            }
            else
            {
                Logger.Log("Located basic level, attempting copy..");
                UndertaleRoom newroom = new UndertaleRoom();
                newroom.Name = data.CreateAndSaveString("snailax_editor_room");
                newroom.Width = copyme_room.Width;
                newroom.Height = copyme_room.Height;
                newroom.BackgroundColor = copyme_room.BackgroundColor;
                newroom.Flags = copyme_room.Flags;

                for (int i = 0; i < copyme_room.Views.Count; i++)
                {
                    UndertaleRoom.View copyview = copyme_room.Views[i];
                    newroom.Views[i] = new UndertaleRoom.View()
                    {
                        Enabled = copyview.Enabled,
                        BorderX = copyview.BorderX,
                        BorderY = copyview.BorderY,
                        ObjectId = copyview.ObjectId,
                        PortHeight = copyview.PortHeight,
                        PortWidth = copyview.PortWidth,
                        PortX = copyview.PortX,
                        PortY = copyview.PortY,
                        ViewHeight = copyview.ViewHeight,
                        ViewWidth = copyview.ViewWidth,
                        ViewX = copyview.ViewX,
                        ViewY = copyview.ViewY,
                        SpeedX = copyview.SpeedX,
                        SpeedY = copyview.SpeedY

                    };
                }

                uint largest_layerid = 0;

                // Find the largest layer id
                // Shamelessly stolen from UMT source
                foreach (UndertaleRoom Room in data.Rooms)
                {
                    foreach (UndertaleRoom.Layer Layer in Room.Layers)
                    {
                        if (Layer.LayerId > largest_layerid)
                            largest_layerid = Layer.LayerId;
                    }
                }

                foreach (UndertaleRoom.Layer copylayer in copyme_room.Layers)
                {
                    UndertaleRoom.Layer layer = new UndertaleRoom.Layer() //thanks to config for making my code actually good :P
                    {
                        LayerId = largest_layerid++, //maybe??
                        LayerName = copylayer.LayerName,
                        LayerType = copylayer.LayerType,
                        IsVisible = copylayer.IsVisible
                    };
                    layer.Data = (UndertaleRoom.Layer.LayerData)Activator.CreateInstance(copylayer.Data.GetType()); //again thanks to config!!!

                    layer.EffectProperties = new UndertaleSimpleList<UndertaleRoom.EffectProperty>();

                    // Somewhat shamefully stolen from UMT source
                    if (layer.LayerType == UndertaleRoom.LayerType.Assets)
                    {
                        // create a new pointer list (if null)
                        layer.AssetsData.LegacyTiles ??= new UndertalePointerList<UndertaleRoom.Tile>();
                        // create new sprite pointer list (if null)
                        layer.AssetsData.Sprites ??= new UndertalePointerList<UndertaleRoom.SpriteInstance>();
                        // create new sequence pointer list (if null)
                        layer.AssetsData.Sequences ??= new UndertalePointerList<UndertaleRoom.SequenceInstance>();
                    }
                    else if (layer.LayerType == UndertaleRoom.LayerType.Tiles)
                    {
                        // create new tile data (if null)
                        layer.TilesData.TileData ??= Array.Empty<uint[]>();
                    }

                    newroom.Layers.Add(layer);

                    newroom.UpdateBGColorLayer();

                    newroom.SetupRoom(false);
                }

                newroom.GridHeight = 60;

                newroom.GridWidth = 60;


                newroom.SetupRoom(false);

                newroom.AddObjectToLayer(data, "obj_level_editor", "Goal");

                newroom.AddObjectToLayer(data, "obj_i_hate_levelstylers", "PostProcessing");

                newroom.AddObjectToLayer(data, "obj_post_processing_draw", "PostProcessing");

                newroom.AddObjectToLayer(data, "obj_music_main", "FadeOutIn");

                newroom.SetupRoom(false);


                data.Rooms.Add(newroom);
            }
            
            //create the hehe funny portal

            UndertaleRoom levelselect = data.Rooms.First(room => room.Name.Content == "level_select");

            UndertaleRoom.GameObject gameobj = levelselect.GameObjects.First(obj => obj.ObjectDefinition.Name.Content == "obj_player");

            UndertaleRoom.GameObject portal = levelselect.AddObjectToLayer(data,"obj_level_select_portal","Goal");

            portal.X = gameobj.X - 120;
            portal.Y = gameobj.Y - 180;

            portal.CreationCode = data.CreateCode("gml_ObjectCC_obj_level_select_portal_Create",GMLkvp["gml_ObjectCC_obj_level_select_portal_Create"],0);


        }
    }
}