
import centroDistri.*

class Vendedores{
	
	var property certificaciones =[]
	
	method agregarCertificacion(certif){ certificaciones.add(certif)}
	method totalCertificaciones()= certificaciones.size()
	method totalPuntos()= certificaciones.sum({ c=> c.puntos()})
	method totalCertifSobreProd()= certificaciones.count({ c=> c.certifSobreProducto()})
	method totalCertifSobreNoProd()= certificaciones.count({ c=> not c.certifSobreProducto()})
	method esVersatil(){
		return self.totalCertificaciones() >=3 and self.totalCertifSobreProd()>=1 and self.totalCertifSobreNoProd()>=1
	}
	method esFirme()= self.totalPuntos()>=30
	method esInfluyente()
	method puedeTrabajar(ciu)
	method esGenerico()= certificaciones.any({c=>c.certifSobreProducto()})
	method tieneAfinidad(centro)= self.puedeTrabajar(centro.ciudad())
	method personaFisica()= true
	
}

class Fijo inherits Vendedores{	
	var property ciudad
	override method puedeTrabajar(ciu)= ciu == ciudad
	override method esInfluyente()= false
}

class Viajante inherits Vendedores{
	var property habilitadoParaTrabajar =#{}
	method agregarProviHabilitadaTrabajar(prov){ habilitadoParaTrabajar.add(prov)}
	method ciudadesDeProvincias()= habilitadoParaTrabajar.flatMap({p=> p.ciudad()})
	override method puedeTrabajar(ciu)=  self.ciudadesDeProvincias().contains(ciu)
	method totalDePoblacion()= habilitadoParaTrabajar.sum({h=> h.poblacion()})
	override method esInfluyente()= self.totalDePoblacion()>=10000000
}


class ComercioCorresponsal inherits Vendedores {
	var property sucursales =[]
	method agregarSucursal(sucu){ sucursales.add(sucu)}
	method ciudadesDeSucursales()= sucursales.map({p=> p.ciudad()})
	override method puedeTrabajar(ciu)= self.ciudadesDeSucursales().contains(ciu)
	method totalSucursales()= sucursales.size()
	method sucursalesEnProvincias()= sucursales.filter({s => s.provincias()}).asSet()
	method totalDeProvincias()= self.sucursalesEnProvincias().size()
	override method esInfluyente()= self.totalSucursales()>=5 and self.totalDeProvincias()>=3
	override method tieneAfinidad(centro)= super(centro) and self.ciudadesDeSucursales().contains(centro.ciudad()) 
	override method personaFisica()= false
}

class Provincia{
	var property poblacion
	var property ciudad=#{}
	
	method agregarCiudad(ciu){ ciudad.add(ciu)}
}
class Ciudad{
	var property provincia
}

class Sucursal{
	var property ciudad
}

class Certificacion{
	var property puntos 
	var property certifSobreProducto
}