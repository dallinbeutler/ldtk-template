package core.debug;

import h3d.Vector;
import h3d.scene.*;
import h3d.scene.fwd.*;

class DrawGrid extends h3d.scene.Graphics {

	public function new( ?parent : Object, size = 10.0, divisions = 10, color1 = 0x444444, color2 = 0x888888, lineWidth = 1.0 ) {

		super( parent );

		material.props = h3d.mat.MaterialSetup.current.getDefaults( "ui" );

		lineShader.width = lineWidth;

		var hsize = size / 2;
		var csize = size / divisions;
		var center = divisions / 2;
		for( i in 0...divisions+1 ) {
			var p = i * csize;
			setColor( ( i!=0 && i!=divisions && i%center==0 ) ? color2 : color1 );
			moveTo( -hsize + p, -hsize, 0 );
			lineTo( -hsize + p, -hsize + size, 0 );
			moveTo( -hsize, -hsize + p, 0 );
			lineTo( -hsize + size, -hsize + p, 0 );
		}
	}
}

class PointLightHelper extends h3d.scene.Mesh {

	public function new( light : h3d.scene.fwd.PointLight, sphereSize = 0.5 ) {
		var prim = new h3d.prim.Sphere( sphereSize, 4, 2 );
		prim.addNormals();
		prim.addUVs();
		super( prim, light );
		material.color = light.color;
		material.mainPass.wireframe = true;
	}
}