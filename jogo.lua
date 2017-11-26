local view = require("view")
local model = require("nave")
local controller = require("controller")
local widget = require("widget")

jogo = {
	
	viewJogador = view,
	modelJogador = model,
	controllerJogador = controller

}


function jogo:play()
	self.viewJogador = view
	self.modelJogador = model
	self.controllerJogador = controller
	self.controllerJogador:play()
end


function timeMovimentacao(event)

	if event.phase == "began" then
		timer.performWithDelay( 500, movimentarNave,0)
	end	
end

function movimentarNave()
	jogo.controllerJogador:movimentaNave()
	jogo.controllerJogador:movimentarInaders()
end


local button = widget.newButton(
    {
        left = 80,
        top = 400,
        id = "button1",
        label = "PLAY",
        shape = "rect",
        onEvent = timeMovimentacao
})

return jogo