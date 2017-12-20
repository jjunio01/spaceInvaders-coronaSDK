local model = require("nave")
local tiros = {}
local physics = require "physics"
physics.start()
local texto = display.newText("Vidas: ", 40, 10)

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

	local posicaoAtual = view.modelJogador.imagem.x
	if posicaoAtual < display.contentWidth - 30 then
		view.modelJogador.imagem.x = view.modelJogador.imagem.x + 10
	end
end

function view.moverNaveEsquerda()

	local posicaoAtual = view.modelJogador.imagem.x
	if posicaoAtual > 30 then
		view.modelJogador.imagem.x = view.modelJogador.imagem.x - 10
	end
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

function view:atualizarVidas()
	local vidas = view.modelJogador.vidas
	texto.text = "Vidas: " .. vidas
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
				view.modelJogador.tabelaInvaders[linha][coluna].y = view.modelJogador.tabelaInvaders[linha][coluna].y + 18
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
	self.modelJogador.imagem.y = display.contentHeight  - 50
	
end

function view:novoTiro()
	local x = view.modelJogador.imagem.x
	local y = view.modelJogador.imagem.y
	table.insert(tiros,display.newRect(x,y - 20, 5,5))	
	physics.addBody( tiros[#tiros], "dynamic")
	physics.setGravity( 0, 0 )
	tiros[#tiros]:setLinearVelocity( 0, -115 )
	tiros[#tiros]:addEventListener( "collision", controller.desativarTiro )
end
function view:novoTiroInvaders(invaders)
	local x = invaders.x
	local y = invaders.y
	table.insert(tiros,display.newRect(x,y + 22, 5,5))
	physics.addBody( tiros[#tiros], "dynamic")
	tiros[#tiros]:addEventListener( "collision", controller.desativarInvaders)
	tiros[#tiros]:setLinearVelocity( 0, 115 )
end

function view:moverTiro(invaders)
	local function mudarPosicao()
		if invaders.y ~= nil then
			invaders.y = invaders.y + 35
		end
	end
	timer.performWithDelay( 500, mudarPosicao,0)
end

return view