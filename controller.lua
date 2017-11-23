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

function controller.movimentacao()
	
	local direita = display.contentWidth - 30
	local esquerda = 30
	local posicaoNave = controller.modelJogador.imagem.x
	local parada = false

	while parada == false do

		if posicaoNave < direita then		
			controller.viewJogador.moverNaveDireita()
		else
			print("oi")
		end	
	end
end



return controller