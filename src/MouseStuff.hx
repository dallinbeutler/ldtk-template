import h3d.scene.Object;
class MouseHelper{
public static function initInteract(s3d:Object, m : h3d.scene.Mesh ) {
    var i= new h3d.scene.Interactive(m.getCollider(), s3d);
    i.propagateEvents = true;
    var beacon = null;
    var color = m.material.color.clone();
    i.bestMatch = true;
    i.onOver = function(e : hxd.Event) {
      m.material.color.set(0, 1, 0);
      var s = new h3d.prim.Sphere(1, 32, 32);
      s.addNormals();
      beacon = new h3d.scene.Mesh(s, s3d);
      beacon.material.mainPass.enableLights = true;
      beacon.material.color.set(1, 0, 0);
      beacon.scale(0.05);
      beacon.x = e.relX;
      beacon.y = e.relY;
      beacon.z = e.relZ;
    };
    i.onMove = i.onCheck = function(e:hxd.Event) {
      if( beacon == null ) return;
      beacon.x = e.relX;
      beacon.y = e.relY;
      beacon.z = e.relZ;
    };
    i.onOut = function(e : hxd.Event) {
      m.material.color.load(color);
      beacon.remove();
      beacon = null;
    };
  }
}