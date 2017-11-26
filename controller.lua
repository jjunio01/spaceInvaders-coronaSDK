local view = require("view")
local model = require("nave")
local movimentoDireita = true
local movimentoEsquerda = false

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

	if movimentoDireita == true then

		if nave < limiteDireita then
			self:movimentarParaDireita()
		else
			movimentoDireita = false
			movimentoEsquerda = true
		end
	end

	if movimentoEsquerda == true then

		if nave >= limiteEsquerda then
			self:movimentarParaEsquerda()
		else
			movimentoDireita = true
			movimentoEsquerda = false
		end
	end
end

function controller:movimentarInvadersParaDireita()
	self.viewJogador:moverInvadersDireita()
end

function controller:movimentarInvadersParaEsquerda()
	self.viewJogador:moverInvadersEsquerda()
end

function controller:movimentarInaders()
		
	self:movimentarInvadersParaDireita()

end

function controller:movimentarParaDireita()

	self.viewJogador.moverNaveDireita()

end

function controller:movimentarParaEsquerda()

	self.viewJogador.moverNaveEsquerda()
end



return controller