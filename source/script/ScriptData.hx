package script;

class ScriptData
{
	public var scripts:Array<HaxeScript> = [];
	public var scriptModScripts:Array<HaxeModScript> = [];

	public function new(scripts:Array<HaxeModScript>)
	{
		for (s in scripts)
		{
			var pth:String = s.daPath;
			trace('path: ' + pth);
			var sc = HaxeScript.create(pth);
			if (sc == null)
				continue;
			ScriptSupport.setScriptDefaultVars(sc, s.daMod, {});
			this.scripts.push(sc);
			scriptModScripts.push(s);
		}
	}

	public function loadFiles()
	{
		for (k => sc in scripts)
		{
			var s = scriptModScripts[k];
			sc.loadFile('${s.daPath}');
		}
	}

	public function executeFunc(funcName:String, ?args:Array<Any>, ?defaultReturnVal:Any)
	{
		var a = args;
		if (a == null)
			a = [];
		for (script in scripts)
		{
			var returnVal = script.executeFunc(funcName, a);
			if (returnVal != defaultReturnVal && defaultReturnVal != null)
			{
				trace("found");
				return returnVal;
			}
		}
		return defaultReturnVal;
	}
	
	public function setVariable(name:String, val:Dynamic)
	{
		for (script in scripts)
			script.setVariable(name, val);
	}

	public function getVariable(name:String, defaultReturnVal:Any)
	{
		for (script in scripts)
		{
			var variable = script.getVariable(name);
			if (variable != defaultReturnVal)
			{
				return variable;
			}
		}
		return defaultReturnVal;
	}

	public function destroy()
	{
		for (script in scripts)
			script.destroy();
		scripts = null;
	}
}
