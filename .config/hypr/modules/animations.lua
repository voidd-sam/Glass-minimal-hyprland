-- ───────────── Curves ─────────────

-- Bezier curves (y > 1 = overshoot = bounce)
hl.curve("overshoot", { type = "bezier", points = { { 0.34, 1.56 }, { 0.64, 1 } } }) -- classic bouncy pop
hl.curve("softBounce", { type = "bezier", points = { { 0.25, 1.25 }, { 0.35, 1 } } }) -- subtle bounce
hl.curve("silk", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } }) -- ultra smooth ease-out (expo)
hl.curve("easeInBack", { type = "bezier", points = { { 0.36, 0 }, { 0.66, -0.2 } } }) -- anticipation on close
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })

-- Springs (physics-based: this is where the "unreal" feel comes from)
-- damping ratio = dampening / (2 * sqrt(mass * stiffness)); lower than 1 = bounce
hl.curve("bouncy", { type = "spring", mass = 1, stiffness = 180, dampening = 14 }) -- ~0.52 ratio, visible bounce
hl.curve("jelly", { type = "spring", mass = 1, stiffness = 120, dampening = 9 }) -- very wobbly
hl.curve("snappy", { type = "spring", mass = 1, stiffness = 300, dampening = 22 }) -- fast, tiny bounce
hl.curve("smooth", { type = "spring", mass = 1, stiffness = 200, dampening = 28 }) -- near critically damped, no bounce

-- ───────────── Animations ─────────────

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "silk" })

-- Windows: spring for move/resize, bouncy pop-in, quick clean exit
hl.animation({ leaf = "windows", enabled = true, speed = 5, spring = "bouncy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, spring = "bouncy", style = "popin 60%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "easeInBack", style = "popin 70%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, spring = "bouncy" })

-- Border
hl.animation({ leaf = "border", enabled = true, speed = 8, bezier = "silk" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "linear", style = "loop" }) -- rotating gradient border

-- Fades
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "silk" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 3, bezier = "silk" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2.5, bezier = "almostLinear" })

-- Layers (rofi, waybar, notifications, etc.)
hl.animation({ leaf = "layers", enabled = true, speed = 5, bezier = "overshoot" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 5, bezier = "overshoot", style = "popin 80%" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3, bezier = "silk", style = "popin 90%" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 3, bezier = "silk" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 2.5, bezier = "almostLinear" })

-- Workspaces: sliding with a soft bounce feels way better than fade
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "softBounce", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 5, bezier = "softBounce", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 5, bezier = "softBounce", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "overshoot", style = "slidevert" })

hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "silk" })
