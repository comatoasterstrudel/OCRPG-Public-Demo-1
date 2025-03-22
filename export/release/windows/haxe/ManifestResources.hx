package;

import haxe.io.Bytes;
import haxe.io.Path;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

#if disable_preloader_assets
@:dox(hide) class ManifestResources {
	public static var preloadLibraries:Array<Dynamic>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;

	public static function init (config:Dynamic):Void {
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
	}
}
#else
@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

			if(!StringTools.endsWith (rootPath, "/")) {

				rootPath += "/";

			}

		}

		if (rootPath == null) {

			#if (ios || tvos || webassembly)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif (console || sys)
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_global_fonts_andy_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		data = '{"name":null,"assets":"ah","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("battle", library);
		data = '{"name":null,"assets":"ah","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("dialogue", library);
		data = '{"name":null,"assets":"ah","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("global", library);
		data = '{"name":null,"assets":"ah","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("menu", library);
		data = '{"name":null,"assets":"ah","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("misc", library);
		Assets.libraryPaths["default"] = rootPath + "manifest/default.json";
		

		library = Assets.getLibrary ("global");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("global");
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

	}


}

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_ai_coma_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_ai_gameshow_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_ai_googly_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_ai_inner_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_ai_random_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_ai_war_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_allydata_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_ally_bad_pizza_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_ally_basic_attack_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_ally_basilisk_venom_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_ally_briefcase_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_ally_disappearing_act_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_ally_greater_good_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_ally_hardened_bash_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_ally_moral_support_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_ally_nano_modify_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_ally_nilrok_shock_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_ally_pizza_wheel_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_ally_prize_ball_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_ally_purple_aura_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_ally_rally_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_ally_spin_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_ally_trained_focus_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_ally_unscrew_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_duo_basic_attack_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_duo_coma_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_duo_luigi_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_duo_outer_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_duo_paragon_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_enemy_basic_attack_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_enemy_bomb_stall_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_enemy_glorp_glorp_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_enemy_glorp_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_enemy_hardened_bash_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_enemy_healing_glorp_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_enemy_heart_stab_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_enemy_leech_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_enemy_moral_support_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_enemy_purple_aura_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_attacks_enemy_rally_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_bannercolors_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_battledata_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_enemyscripts_coma_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_enemyscripts_googly_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_enemyscripts_inner_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_enemyscripts_tutorial_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_enemyscripts_war_hx extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_gameshowquestions_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_moveinfo_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_data_songnames_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_aura_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_aura_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_bash_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_bash_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_basic_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_basic_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_bomb_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_bomb_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_case_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_case_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_dad_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_dad_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_defense_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_defense_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_duocoma_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_duocoma_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_duoluigi_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_duoluigi_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_duoouter_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_duoouter_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_duoparagon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_duoparagon_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_glorp_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_glorp_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_leach_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_leach_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_nano_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_nano_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_nilrokshock_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_nilrokshock_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_pizzawheel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_pizzawheel_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_prize_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_prize_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_rally_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_rally_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_sewerslide_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_sewerslide_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_shitpizza_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_shitpizza_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_slimeheal_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_slimeheal_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_spin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_spin_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_stab_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_stab_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_support_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_support_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_train_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_train_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_unscrew_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_unscrew_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_venom_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_venom_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_what_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_attackanims_attackanim_what_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_backgrounds_bg_barbany_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_backgrounds_bg_barbany_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_backgrounds_bg_cave_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_backgrounds_bg_cave_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_backgrounds_bg_hearter_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_backgrounds_bg_hearter_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_backgrounds_bg_placeholder_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_backgrounds_bg_placeholder_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_backgrounds_bg_slimefall_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_backgrounds_bg_slimefall_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_backgrounds_bg_war_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_backgrounds_bg_war_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_banner_bg_bannerback_horizontal_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_banner_bg_bannerback_vertical_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_banner_bg_bannerfront_horizontal_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_banner_bg_bannerfront_vertical_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_banner_sprites_sprite_boss_coma_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_banner_sprites_sprite_boss_gameshow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_banner_sprites_sprite_boss_googly_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_banner_sprites_sprite_boss_inner_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_banner_sprites_sprite_boss_tutorial_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_banner_sprites_sprite_boss_war_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_banner_sprites_sprite_coma_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_banner_sprites_sprite_luigi_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_banner_sprites_sprite_outer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_banner_sprites_sprite_paragon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_bossspecific_gameshow_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_bossspecific_gameshow_comabomberletsgo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_bossspecific_gameshow_comabomberletsgo_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_bossspecific_gameshow_flasher_lose_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_bossspecific_gameshow_flasher_lose_scary_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_bossspecific_gameshow_flasher_win_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_bossspecific_gameshow_flasher_win_scary_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_bossspecific_gameshow_rope_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_bossspecific_gameshow_thecomasareweeping_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_bossspecific_inner_innerbarsprite_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_bossspecific_inner_innerbarsprite_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_bossspecific_inner_innerjumpscare_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_bossspecific_inner_innerjumpscare_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_bossspecific_inner_innerscare_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_bossspecific_inner_static_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_bossspecific_inner_static_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_bossspecific_war_warfallsprite_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_duo_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_duo_sprites_comaluigi_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_duo_sprites_comaouter_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_duo_sprites_comaparagon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_duo_sprites_outerluigi_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_duo_sprites_outerparagon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_duo_sprites_paragonluigi_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_duo_sprites_placeholder_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_enemy_opponent_coma_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_enemy_opponent_coma_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_enemy_opponent_gameshow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_enemy_opponent_gameshow_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_enemy_opponent_googly_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_enemy_opponent_googly_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_enemy_opponent_inner_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_enemy_opponent_inner_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_enemy_opponent_innerpuppet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_enemy_opponent_innerpuppet_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_enemy_opponent_tutorial_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_enemy_opponent_tutorial_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_enemy_opponent_war_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_enemy_opponent_war_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_portraits_portrait_coma_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_portraits_portrait_coma_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_portraits_portrait_luigi_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_portraits_portrait_luigi_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_portraits_portrait_luigi_flipped_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_portraits_portrait_luigi_flipped_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_portraits_portrait_outer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_portraits_portrait_outer_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_portraits_portrait_paragon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_portraits_portrait_paragon_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_intro_ally_coma_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_intro_ally_luigi_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_intro_ally_outer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_intro_ally_paragon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_intro_enemy_coma_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_intro_enemy_googly_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_intro_enemy_inner_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_intro_enemy_tutorial_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_intro_enemy_war_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_lose_ally_coma_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_lose_ally_luigi_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_lose_ally_outer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_lose_ally_paragon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_lose_enemy_coma_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_lose_enemy_googly_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_lose_enemy_inner_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_lose_enemy_tutorial_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_win_ally_coma_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_win_ally_luigi_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_win_ally_outer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_win_ally_paragon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_win_bigredx_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_win_enemy_coma_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_win_enemy_googly_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_win_enemy_inner_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_win_enemy_tutorial_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_words_and_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_words_ated_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_words_char_barnaby_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_words_char_coma_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_words_char_googly_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_words_char_inner_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_words_char_luigi_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_words_char_outer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_words_char_paragon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_words_char_tutorial_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_words_char_war_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_words_defe_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_words_s_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_splashscreens_words_v_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_ui_battlelowerbar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_ui_duoprompt_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_ui_enemyhpbar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_ui_hpbar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_ui_motivationbar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_ui_motivationbarbg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_ui_musicnote_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_ui_quicktimeeventbar_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_ui_quicktimeeventline_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_ui_turnindicator_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_images_ui_turnindicator_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_music_battleintro_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_music_battleintroboss_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_music_battlelose_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_music_battlewin_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_music_battlewinboss_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_music_bosstheme_coma_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_music_bosstheme_comadepression_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_music_bosstheme_comagameshow_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_music_bosstheme_googly_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_music_bosstheme_inner_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_music_bosstheme_innerscary_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_music_bosstheme_tutorial_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_music_bosstheme_war_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_aura_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_basicattack_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_bompplace_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_bompplode_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_briefcase_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_capsule_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_dad_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_dontlectureme_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_duocoma_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_duoluigihit_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_duoluigispin_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_duoouter_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_duoparagon_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_glorp_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_glorpdefense_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_glorpglorp_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_glorpheal_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_greatergoodone_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_greatergoodtwo_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_hardbash_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_leech_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_moralsupport_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_nano_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_nilrokslash_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_rally_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_spin_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_stab_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_train_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_unscrew_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_unscrewfail_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_unscrewsucceed_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_venomshot_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_what_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_wheelhit_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_attacksfx_wheelplace_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_death_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_dodge_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_revive_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_screamer_comadies_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_screamer_googlydies_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_statdown_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_battle_sounds_statup_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_dia_placeholder_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_gameshow_dia_cmgs_battlelost_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_gameshow_dia_cmgs_battlewon_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_gameshow_dia_cmgs_early_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_gameshow_dia_cmgs_hurt_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_gameshow_dia_cmgs_intro1_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_gameshow_dia_cmgs_intro2_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_gameshow_dia_cmgs_lose_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_gameshow_dia_cmgs_opening_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_gameshow_dia_cmgs_win_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_intro_coma_dia_intro_coma_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_intro_coma_dia_intro_googly_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_intro_coma_dia_intro_inner_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_intro_coma_dia_intro_war_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_intro_luigi_dia_intro_coma_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_intro_luigi_dia_intro_googly_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_intro_luigi_dia_intro_inner_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_intro_luigi_dia_intro_war_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_intro_outer_dia_intro_coma_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_intro_outer_dia_intro_googly_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_intro_outer_dia_intro_inner_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_intro_outer_dia_intro_war_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_intro_paragon_dia_intro_coma_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_intro_paragon_dia_intro_googly_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_intro_paragon_dia_intro_inner_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_intro_paragon_dia_intro_war_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_dia_sb_exhausted_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_dia_sb_intro_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_areyoumarried_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_beans_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_beanslaw_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_cancer_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_corrupt_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_criminalexploderterrorist_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_ctrnf_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_davidkun_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_diesixteentimes_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_divorce_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_doorhandle_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_favor_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_funfood_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_gigigi_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_googlyfamily_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_hihihi_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_lilcoma_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_noblinking_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_pawdabber_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_reallylong_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_seeds_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_slugs_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_thestonesareweeping_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_saveboy_random_dia_sb_timemachine_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_tutorial_dia_tut_01_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_tutorial_dia_tut_02_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_tutorial_dia_tut_03_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_tutorial_dia_tut_04_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_tutorial_dia_tut_05_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_tutorial_dia_tut_ignore_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_tutorial_dia_tut_intro_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_tutorial_dia_tut_lose_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_tutorial_dia_tut_win_interrupt_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_dialogue_tutorial_dia_tut_win_normal_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_data_textcolors_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_dialoguebox_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_comagameshow_cry_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_comagameshow_happy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_comagameshow_mad_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_comagameshow_neutral_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_comagameshow_sob_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_comagameshow_stare_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_coma__w__png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_coma_annoy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_coma_bored_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_coma_happy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_coma_idea_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_coma_neutral_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_coma_scared_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_coma_smirk_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_coma_stare_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_ctrnf_explain_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_ctrnf_happy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_ctrnf_huh_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_ctrnf_neutral_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_ctrnf_stare_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_luigi_neutral_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_luigi_scared_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_luigi_shrug_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_outer_cringe_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_outer_happier_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_outer_happy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_outer_scared_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_outer_smirk_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_outer_yell_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_paragon_basiliskcringe_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_paragon_basiliskeh_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_paragon_basilisksurprise_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_paragon_domino_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_paragon_nilrok_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_paragon_nix_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_paragon_nix2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_images_portraits_paragon_shroud_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_music_diaintro_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_sounds_close_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_sounds_text_textbasilisk_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_sounds_text_textcoma_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_sounds_text_textctrnf_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_sounds_text_textdefault_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_sounds_text_textdomino_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_sounds_text_textluigi_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_sounds_text_textnilrok_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_sounds_text_textnix_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_sounds_text_textouter_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_sounds_text_textsaveboy_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_dialogue_sounds_text_textshroud_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_global_fonts_andy_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_global_images_icons_icon120_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_global_images_icons_icon16_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_global_images_icons_icon32_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_global_images_icons_icon60_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_global_images_icons_iconog_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_global_images_icons_iconold_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_global_images_saveindicator_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_global_sounds_tvtran_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_global_sounds_volchange_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_data_allybios_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_data_creditslist_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_data_gauntlet_beginner_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_data_gauntlet_gl_list_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_data_gauntlet_horror_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_data_menubattlelist_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_characterselect_biobubble_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_characterselect_biobubble_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_checker_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_creditmenu_credsprite_coma_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_creditmenu_credsprite_coma_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_creditmenu_credsprite_doodslr_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_creditmenu_credsprite_doodslr_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_creditmenu_credsprite_kyzroen_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_creditmenu_credsprite_kyzroen_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_creditmenu_credsprite_oc_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_creditmenu_credsprite_oc_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_creditmenu_credsprite_outer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_creditmenu_credsprite_outer_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_creditmenu_credsprite_placeholder_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_creditmenu_credsprite_placeholder_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_creditmenu_credsprite_smalarie_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_creditmenu_credsprite_smalarie_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_gauntletselect_bg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_gauntletselect_gauntletsprites_beginner_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_gauntletselect_gauntletsprites_horror_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_instructions_controller_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_instructions_controller_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_instructions_keyboard_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_instructions_keyboard_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_back_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_back_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_extras_sound_test_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_extras_sound_test_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_main_credits_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_main_credits_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_main_extras_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_main_extras_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_main_play_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_main_play_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_main_quit_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_main_quit_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_main_settings_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_main_settings_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_placeholder_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_placeholder_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_play_change_characters_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_play_change_characters_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_play_freeplay_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_play_freeplay_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_play_gauntlets_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_play_gauntlets_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_play_tutorial_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_play_tutorial_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_buttons_play_zip extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_checker_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_logos_fnf_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_logos_luigi_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_logos_main_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_logos_minecraft_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_logos_off_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_logos_omori_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_logos_pixel_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_logos_saster_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_logos_terraria_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_logos_undertale_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_mainmenu_logos_yokai_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_pausemenu_checker_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_pausemenu_dancer_coma_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_pausemenu_dancer_coma_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_pausemenu_dancer_luigi_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_pausemenu_dancer_luigi_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_pausemenu_dancer_outer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_pausemenu_dancer_outer_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_pausemenu_dancer_paragon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_pausemenu_dancer_paragon_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_saveselect_counter_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_saveselect_saveboy_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_saveselect_saveboy_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_saveselect_sign_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_images_soundtest_soundtestrecord_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_music_charselect_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_music_credits_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_music_gauntlet_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_music_instruction_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_music_menu_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_music_options_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_music_pause_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_music_saveboy_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_sounds_gauntletstart_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_sounds_saveboyscream_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_sounds_scroll_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_menu_sounds_select_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_data_vanityname_ally_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_data_vanityname_enemy_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_data_vanityname_gauntlet_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_images_charactericons_ally_coma_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_images_charactericons_ally_luigi_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_images_charactericons_ally_outer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_images_charactericons_ally_paragon_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_images_introsplashscreen_coma_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_images_introsplashscreen_companylogo_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_images_introsplashscreen_outer_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_sounds_gameshowlose_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_sounds_gameshowweird_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_sounds_gameshowwin_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_sounds_honk_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_sounds_hugeexplosion_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_sounds_innerscarelong_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_sounds_innerscareshort_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_sounds_recordscratch_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_sounds_splashsound_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_sounds_static_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_misc_sounds_tablebreak_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__imp_changelog_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__imp_readme_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__modding_currentmod_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_battle_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_dialogue_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_global_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_menu_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_misc_json extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/5,6,0/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/5,6,0/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("C:/HaxeToolkit/haxe/lib/flixel/5,6,0/assets/fonts/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("C:/HaxeToolkit/haxe/lib/flixel/5,6,0/assets/fonts/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/5,6,0/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/5,6,0/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("export/release/windows/obj/tmp/manifest/battle.json") @:noCompletion #if display private #end class __ASSET__manifest_battle_json extends haxe.io.Bytes {}
@:keep @:file("export/release/windows/obj/tmp/manifest/dialogue.json") @:noCompletion #if display private #end class __ASSET__manifest_dialogue_json extends haxe.io.Bytes {}
@:keep @:file("export/release/windows/obj/tmp/manifest/global.json") @:noCompletion #if display private #end class __ASSET__manifest_global_json extends haxe.io.Bytes {}
@:keep @:file("export/release/windows/obj/tmp/manifest/menu.json") @:noCompletion #if display private #end class __ASSET__manifest_menu_json extends haxe.io.Bytes {}
@:keep @:file("export/release/windows/obj/tmp/manifest/misc.json") @:noCompletion #if display private #end class __ASSET__manifest_misc_json extends haxe.io.Bytes {}

@:keep @:noCompletion #if display private #end class __ASSET__assets_global_fonts_andy_ttf extends lime.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "assets/global/fonts/andy.ttf"; name = "Andy Bold"; super (); }}


#else

@:keep @:expose('__ASSET__assets_global_fonts_andy_ttf') @:noCompletion #if display private #end class __ASSET__assets_global_fonts_andy_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/global/fonts/andy.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Andy Bold"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat.ttf"; #else ascender = null; descender = null; height = null; numGlyphs = null; underlinePosition = null; underlineThickness = null; unitsPerEM = null; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__assets_global_fonts_andy_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_global_fonts_andy_ttf extends openfl.text.Font { public function new () { name = "Andy Bold"; super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__assets_global_fonts_andy_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_global_fonts_andy_ttf extends openfl.text.Font { public function new () { __fontPath = ManifestResources.rootPath + "assets/global/fonts/andy.ttf"; name = "Andy Bold"; super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end