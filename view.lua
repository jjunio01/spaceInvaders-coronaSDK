local model = require("nave")

view = {

	controllerJogador = controller,
	modelJogador = model	

}


function view:play(controller)
	self.controllerJogador = controller
	self.modelJogador = model
	self:desenharNave()	
end

function view.moverNaveDireita()
	
	view.modelJogador.imagem.x = view.modelJogador.imagem.x + 10

end

function view.moverNaveEsquerda()
	
	view.modelJogador.imagem.x = view.modelJogador.imagem.x - 10

end


function view:desenharNave()

	self.modelJogador.imagem.x = display.contentWidth / 2
	self.modelJogador.imagem.y = display.contentHeight / 2
	self.modelJogador.imagem.width= 50
	self.modelJogador.imagem.height = 50	
end






return view