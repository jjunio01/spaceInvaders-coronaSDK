local view = require("view")
local model = require("nave")

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
	local direita = display.contentWidth - 30
	local esquerda = 30
	local movimento = "direita"

	if self.viewJogador.modelJogador.imagem.x == direita then
		movimento = "esquerda"
	elseif self.viewJogador.modelJogador.imagem.x == 30 then
		movimento = "direita"
	end

	if movimento == "direita" then
		self:movimentarParaDireita()
	end

	if movimento == "esquerda" then
		self:movimentarParaEsquerda()
	end
end


function controller:movimentarParaDireita()

	self.viewJogador.moverNaveDireita()

end

function controller:movimentarParaEsquerda()

	self.viewJogador.moverNaveEsquerda()
end



return controller