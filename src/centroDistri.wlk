
import vendedores.*

class CentroDistribucion {
	var property ciudad
	var property vendedores= #{}
	
	method agregarVendedor(vendedor){
		if (vendedores.contains(vendedor)){
			self.error("el vendedor ya esta en el centro")
		}else{
			vendedores.add(vendedor)
		}
	}
	method vendedorEstrella()= vendedores.max({v=> v.totalCertificaciones()})
	method puedeCubrir(ciu)= vendedores.any({v=> v.puedeTrabajar(ciu)})
	method vendedoresGenericos()=vendedores.filter({v=> v.esGenerico()})
	method esRobusto()= vendedores.count({v=> v.esFirme()}) >=3
	method repartaUnaNotificacion(certif){vendedores.forEach({v => v.agregarCertificacion(certif)})}
	method esCandidato(vendedor)= vendedor.esVersatil() and vendedor.tieneAfinidad(self)
}
