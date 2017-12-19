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

	--if event.phase == "began" then
		timer.performWithDelay( 500, movimentarInvaders,0)
		timer.performWithDelay( 1500, atirarInvaders,0)
	--end
end

function novoTiro()
	jogo.controllerJogador:atirar()
end

function atirar(event)
	if event.phase == "began" then
		timer.performWithDelay( 500, novoTiro)
		--jogo.controllerJogador:atirar()
	end
end

function movimentarInvaders()
	--jogo.controllerJogador:movimentaNave()
	jogo.controllerJogador:movimentarInaders()
end	

function atirarInvaders()
	jogo.controllerJogador:tiroInvaders()
end

function jogo:vidaNave()
	self.controllerJogador:verificarVidaNave()
end

function jogo:mostrarNumeroDeVidas()
	self.viewJogador:atualizarVidas()
end

function movimentarEsquerda(event)
	if event.phase == "began" then
		jogo.controllerJogador:movimentarParaEsquerda()
	end
end

function movimentarDireita(event)
	if event.phase == "began" then
		jogo.controllerJogador:movimentarParaDireita()
	end
end

jogo:mostrarNumeroDeVidas()

local button = widget.newButton(
    {
        left = 15,
        top = 450,
        id = "button1",
        label = "E",
        shape = "rect",
        onEvent = movimentarEsquerda,
     	width = 60,
		height = 60
})

local button = widget.newButton(
    {
        left = 80,
        top = 450,
        id = "button1",
        label = "D",
        shape = "rect",
        onEvent = movimentarDireita,
     	width = 60,
		height = 60
})

timeMovimentacao()

local button = widget.newButton(
    {
        left = 250,
        top = 450,
        id = "button1",
        label = "TIRO",
        shape = "rect",
        onEvent = atirar,
     	width = 60,
		height = 60
})

return jogo