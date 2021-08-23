function ReturnTab(count)
    let l:tab = ""
    for i in range(a:count)
        let l:tab .= '  '
    endfor
    return l:tab
endfunction

function ReturnSpace(count)
    let l:tab = ""
    for i in range(a:count)
        let l:tab .= ' '
    endfor
    return l:tab
endfunction

function ExtraSpace()
    return "\ "
endfunction

function GearIcon()
    return " "
endfunction

function LineNrIcon()
    return "並"
endfunction

function LeftHCircleDivider()
    return '' 
endfunction

function RightHCircleDivider()
    return ' '
endfunction

function RightArrowDivider()
    return ' '
endfunction

function LeftArrowDivider()
    return ' ' 
endfunction

function LeftChevron()
    return ' '
endfunction

function RightChevron()
    return ' '
endfunction

function GitIcon()
    return ' '
endfunction

function Divider()
    return "::"
endfunction
