import vendedores.*

class Inseguro {
	method puedeSerAtendido(vendedor)= vendedor.esVersatil() and vendedor.esFirme()
}

class Detallista {
	method puedeSerAtendido(vendedor)= vendedor.totalCertifSobreProd() >=3
}
class Humanista {
	
	method puedeSerAtendido(vendedor)= vendedor.personaFisica()
}