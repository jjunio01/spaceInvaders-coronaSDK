local model = require("nave")
local tiros = {}
local physics = require "physics"
physics.start()

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

function view:verificarInvaders(linha, coluna)

	if view.modelJogador.tabelaInvaders[linha][coluna].x ~= nil 
		and view.modelJogador.tabelaInvaders[linha][coluna].y ~= nil then
		return true
	else
		return false
	end
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
			if self:verificarInvaders(linha, coluna) then
				self.modelJogador.tabelaInvaders[linha][coluna].x = view.modelJogador.tabelaInvaders[linha][coluna].x + 10
			end
		end
	end
end

function view:moverInvadersEsquerda()

	for linha=1,3 do
		for coluna=1,10 do
			if self:verificarInvaders(linha, coluna) then
				self.modelJogador.tabelaInvaders[linha][coluna].x = view.modelJogador.tabelaInvaders[linha][coluna].x - 10
			end
		end
	end
end

function view:moverInvadersParaBaixo()
	for linha=1,3 do
		for coluna=1,10 do
			if self:verificarInvaders(linha, coluna) then
				view.modelJogador.tabelaInvaders[linha][coluna].y = view.modelJogador.tabelaInvaders[linha][coluna].y + 10
			end
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
	self.modelJogador.imagem.y = display.contentHeight  - 100
	
end

function view:novoTiro()
	local x = view.modelJogador.imagem.x
	local y = view.modelJogador.imagem.y
	table.insert(tiros,display.newRect(x,y, 5,5))	
	physics.addBody( tiros[#tiros], "dynamic")
	physics.setGravity( 0, -6 )
	tiros[#tiros]:addEventListener( "collision", controller.desativarTiro )
end

return view