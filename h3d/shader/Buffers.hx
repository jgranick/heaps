package h3d.shader;

@:enum abstract BufferKind(Int) {
	public var Globals = 0;
	public var Params = 1;
	public var Textures = 2;
}

typedef ShaderBufferData = #if flash haxe.ds.Vector<hxd.impl.Float32> #elseif lime lime.utils.Float32Array #elseif js js.html.Float32Array #else haxe.ds.Vector<hxd.impl.Float32> #end;

class ShaderBuffers {

	public var globals : ShaderBufferData;
	public var params : ShaderBufferData;
	public var tex : haxe.ds.Vector<h3d.mat.Texture>;

	public function new( s : hxsl.RuntimeShader.RuntimeShaderData ) {
		globals = new ShaderBufferData(s.globalsSize<<2);
		params = new ShaderBufferData(s.paramsSize<<2);
		tex = new haxe.ds.Vector(s.textures2DCount + s.texturesCubeCount);
	}

	public function grow( s : hxsl.RuntimeShader.RuntimeShaderData ) {
		var ng = s.globalsSize << 2;
		var np = s.paramsSize << 2;
		var nt = s.textures2DCount + s.texturesCubeCount;
		if( globals.length < ng ) globals = new ShaderBufferData(ng);
		if( params.length < np ) params = new ShaderBufferData(np);
		if( tex.length < nt ) tex = new haxe.ds.Vector(nt);
	}

}

class Buffers {

	public var vertex : ShaderBuffers;
	public var fragment : ShaderBuffers;

	public function new( s : hxsl.RuntimeShader ) {
		vertex = new ShaderBuffers(s.vertex);
		fragment = new ShaderBuffers(s.fragment);
	}

	public inline function grow( s : hxsl.RuntimeShader ) {
		vertex.grow(s.vertex);
		fragment.grow(s.fragment);
	}
}

