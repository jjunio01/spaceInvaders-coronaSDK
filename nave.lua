local tabelaNaves = {}

nave = {
	vidas = 3,
	imagem = display.newImage("nave.png"),
	tabelaInvaders = {}
}

function nave:play()
	self:inicializarInvaders()
end


function nave:renderizar()
	
	self.imagem.width= 20
	self.imagem.height = 20

end

function nave:inicializarInvaders()

	for linha = 1, 3 do	
		self.tabelaInvaders[linha] = {}
		for coluna=1,10 do
			self.tabelaInvaders[linha][coluna] = display.newImage("nave.png")
			self.tabelaInvaders[linha][coluna].width = 20
			self.tabelaInvaders[linha][coluna].height = 20
		end	
	end
end

return nave