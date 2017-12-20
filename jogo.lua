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
	self:mostrarNumeroDeVidas()
	timeMovimentacao()
	timeTiroInvaders()
end

function timeTiroInvaders()
	invaders = timer.performWithDelay( 1000, atirarInvaders,0)
end

function timeMovimentacao(event)
	timer.performWithDelay( 500, movimentarInvaders,0)
end

function novoTiro()
	jogo.controllerJogador:atirar()
end

function atirar(event)
	if event.phase == "began" then
		timer.performWithDelay( 500, novoTiro)
	end
end

function movimentarInvaders()
	jogo.controllerJogador:movimentarInaders()
	jogo:verificaTermino()
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

function movimentarNaveEsquerda(event)
	if event.phase == "began" then
		jogo.controllerJogador:movimentarParaEsquerda()
	end
end

function movimentarNaveDireita(event)
	if event.phase == "began" then
		jogo.controllerJogador:movimentarParaDireita()
	end
end

local buttonE = widget.newButton(
    {
        left = 15,
        top = 450,
        id = "button1",
        label = "E",
        shape = "rect",
        onEvent = movimentarNaveEsquerda,
     	width = 60,
		height = 60
})

local buttonD = widget.newButton(
    {
        left = 80,
        top = 450,
        id = "button1",
        label = "D",
        shape = "rect",
        onEvent = movimentarNaveDireita,
     	width = 60,
		height = 60
})

local buttonT = widget.newButton(
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

function jogo:verificaTermino()
	if self.controllerJogador:verificarFinalDeJogo() == true then
		buttonT:setEnabled(false)
		buttonE:setEnabled(false)
		buttonD:setEnabled(false)
		timer.cancel(invaders)
	end
end

return jogo