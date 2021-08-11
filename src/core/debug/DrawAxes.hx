package core.debug;

class DrawAxes extends h3d.scene.Graphics {

	public function new( ?parent : h3d.scene.Object, size = 2.0, lineWidth = 2.0, colorX = 0xEB304D, colorY = 0x7FC309, colorZ = 0x288DF9 ) {

		super( parent );

		material.props = h3d.mat.MaterialSetup.current.getDefaults( "ui" );

		lineShader.width = lineWidth;

		setColor( colorX );
		lineTo( size, 0, 0 );

		setColor( colorY );
		moveTo( 0, 0, 0 );
		lineTo( 0, size, 0 );

		setColor( colorZ );
		moveTo( 0, 0, 0 );
		lineTo( 0, 0, size );
	}
}