import strutils
import nimcrypto


type Block = ref object
    data: string
    prevHash: string


proc `$`(b: Block): string =
    return b.data & ":" & b.prevHash


proc genHashchain(iv: string, datalist: seq[string]): seq[Block] =
    var hashchain: seq[Block] = @[]
    var prev: string = iv

    for d in datalist:
        let b = Block(data: d, prevHash: prev)
        hashchain.add(b)
        prev = ($sha256.digest($b)).toLower()
    
    return hashchain


proc main() =
    let datalist = @["0001", "0002", "0003", "0004"]
    let iv = "0000"

    let hashchain = genHashchain(iv, datalist)
    
    echo hashchain
    echo ($sha256.digest($hashchain[hashchain.len-1])).toLower()


when isMainModule:
    main()
