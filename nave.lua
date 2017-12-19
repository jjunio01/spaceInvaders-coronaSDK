local physics = require "physics"

nave = {
	vidas = 3,
	imagem = display.newImage("nave.png"),
	tabelaInvaders = {}
}

function nave:renderizar()
	
	self.imagem.width= 20
	self.imagem.height = 20
	physics.addBody(self.imagem, "static")
	physics.setGravity( 0, 0 )

end

function nave:inicializarInvaders()
	physics.start()
	for linha = 1, 3 do	
		self.tabelaInvaders[linha] = {}
		for coluna=1,10 do
			self.tabelaInvaders[linha][coluna] = display.newImage("nave.png")
			self.tabelaInvaders[linha][coluna].width = 20
			self.tabelaInvaders[linha][coluna].height = 20
			physics.addBody( self.tabelaInvaders[linha][coluna], "static")
			self.tabelaInvaders[linha][coluna]:addEventListener( "collision", controller.desativarInvaders )				
		end	
	end
end

return nave