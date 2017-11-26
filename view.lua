local model = require("nave")

view = {

	controllerJogador = controller,
	modelJogador = model	

}


function view:play(controller)
	self.controllerJogador = controller
	self.modelJogador = model
	self:desenharNave()
	self:desenharInvaders()
end

function view.moverNaveDireita()
	
	view.modelJogador.imagem.x = view.modelJogador.imagem.x + 10

end

function view.moverNaveEsquerda()
	
	view.modelJogador.imagem.x = view.modelJogador.imagem.x - 10

end

function view:moverInvadersDireita()
	
	for linha=1,3 do
		for coluna=1,10 do
			print()
			view.modelJogador.tabelaInvaders[linha][coluna].x = view.modelJogador.tabelaInvaders[linha][coluna].x + 10
		end
	end
end

function view:moverInvadersEsquerda()

	for linha=1,3 do
		for coluna=1,10 do
			view.modelJogador.tabelaInvaders[linha][coluna].x = view.modelJogador.tabelaInvaders[linha][coluna].x - 10
		end
	end
end

function view:desenharInvaders()

	self.modelJogador:inicializarInvaders()

	local incrementoColuna = 0
	local incrementoLinha = 0

	for linha = 1, 3 do
		for coluna = 1, 10 do
			self.modelJogador.tabelaInvaders[linha][coluna].x = 40 + incrementoLinha
			self.modelJogador.tabelaInvaders[linha][coluna].y = 40 + incrementoColuna
			incrementoLinha = incrementoLinha + 25
		end
		incrementoLinha = 0
		incrementoColuna = incrementoColuna + 25
	end
end


function view:desenharNave()

	self.modelJogador:renderizar()
	self.modelJogador.imagem.x = display.contentWidth / 2
	self.modelJogador.imagem.y = display.contentHeight / 2
	
end






return view