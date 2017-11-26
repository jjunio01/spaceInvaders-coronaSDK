local view = require("view")
local model = require("nave")
local movimentoNaveDireita = true
local movimentoNaveEsquerda = false
local movimentoDireita = true
local movimentoEsquerda = false
local tiro = display.newRect(display.contentWidth / 2,display.contentHeight  - 100, 5,5)

controller = {	
	
	viewJogador = view,
	modelJogador = model

}

function controller:play()	
	self.viewJogador = view
	self.modelJogador = model	
	self.viewJogador:play(self)
end

function controller:movimentaNave()

	local limiteDireita = display.contentWidth - 25
	local nave = self.viewJogador.modelJogador.imagem.x
	local limiteEsquerda = 35

	if movimentoNaveDireita == true then

		if nave < limiteDireita then
			self:movimentarParaDireita()
		else
			movimentoNaveDireita = false
			movimentoNaveEsquerda = true
		end
	end

	if movimentoNaveEsquerda == true then

		if nave >= limiteEsquerda then
			self:movimentarParaEsquerda()
		else
			movimentoNaveDireita = true
			movimentoNaveEsquerda = false
		end
	end
end

function controller:verificarLimiteInvaders(invaders)
	
	if invaders < limiteDireita then
		return true
	else
		return false
	end
end

function controller:movimentarInvadersParaDireita()
	self.viewJogador:moverInvadersDireita()
end

function controller:movimentarInvadersParaEsquerda()
	self.viewJogador:moverInvadersEsquerda()
end

function controller:descerInvaders()
	self.viewJogador:moverInvadersParaBaixo()
end

function controller:movimentarInaders()
	local limiteDireita = display.contentWidth - 25
	local invadersDireita = self.viewJogador.modelJogador.tabelaInvaders[1][10].x
	local limiteEsquerda = 35
	local invadersEsquerda = self.viewJogador.modelJogador.tabelaInvaders[1][1].x

	if movimentoDireita == true then

		if invadersDireita < limiteDireita then
			self:movimentarInvadersParaDireita()
		else
			movimentoDireita = false
			movimentoEsquerda = true
			self:descerInvaders()
		end
	end

	if movimentoEsquerda == true then

		if invadersEsquerda >= limiteEsquerda then
			self:movimentarInvadersParaEsquerda()
		else
			movimentoDireita = true
			movimentoEsquerda = false
			self:descerInvaders()
		end
	end

end

function controller:atirar()
	tiro.y = tiro.y - 30
end

function controller:movimentarParaDireita()

	self.viewJogador.moverNaveDireita()

end

function controller:movimentarParaEsquerda()

	self.viewJogador.moverNaveEsquerda()
end



return controller