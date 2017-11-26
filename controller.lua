local view = require("view")
local model = require("nave")
local movimentoDireta = true
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

	local limiteDireita = display.contentWidth - 30
	local nave = self.viewJogador.modelJogador.imagem.x
	local limiteEsquerda = 30

	if movimentoDireta == true then

		if nave < limiteDireita then
			self:movimentarParaDireita()
		else
			movimentoDireta = false
			movimentoEsquerda = true
		end
	end

	if movimentoEsquerda == true then

		if nave >= limiteEsquerda then
			self:movimentarParaEsquerda()
		else
			movimentoDireta = true
			movimentoEsquerda = false
		end
	end
end


function controller:movimentarParaDireita()

	self.viewJogador.moverNaveDireita()

end

function controller:movimentarParaEsquerda()

	self.viewJogador.moverNaveEsquerda()
end



return controller