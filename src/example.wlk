class Persona{
	var property celulas 
	var property temperatura 
	const enfermedades = []
	method pasarUnDia(){
		enfermedades.forEach({enfermedad => enfermedad.causarEfecto(self)})
	}
	method contraer(enfermedad){
		enfermedades.add(enfermedad)
	}
	method aumentarTemperatura(valor){
		temperatura += valor 
	}
	method disminuirCelulas(cantidad){
		celulas -= cantidad
	}
	method estaEnComa() = temperatura == 45 or celulas < 1000000
	method celulasAmenazadas(){
		enfermedades.filter({enfermedad => enfermedad.esAgresiva(self)}).sum({enfermedad => enfermedad.celulas()})
	}
	method recibirMedicacion(cant){
		enfermedades.forEach({enfermedad => enfermedad.atenuar(cant * 15)})
	}
	method contraerMuerte(){
		temperatura = 0
	}
}

class Enfermedad{
	var property celulas 
	var property dias = 0
	method atenuar(cant){
		celulas -= cant
	}
}

class EnfermedadInfecciosa inherits Enfermedad{
	method causarEfecto(persona){
		persona.aumentarTemperatura(celulas/1000)
		dias += 1
	}
	method reproducirse(){
		celulas = celulas * 2
	}
	method esAgresiva(persona) = celulas > persona.celulas()/ 10
	
}

class EnfermedadAutoinmune inherits Enfermedad{
	method causarEfecto(persona){
		persona.diminuirCelulas(celulas)
		dias += 1
	}
	method esAgresiva(persona) =  dias > 30
}

class Medico inherits Persona{
	var property dosis 
	var property enfermo 
	method atender(persona){
		persona.recibirMedicacion(dosis)
	}
}
