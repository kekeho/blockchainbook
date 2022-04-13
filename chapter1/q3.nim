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


proc check(iv: string, hashchain: seq[Block]): bool =
    # 後ろから先頭の1つ手前まで, prevHashと1つ前のブロックのハッシュ値が等しいか検証していく
    for i in 1..hashchain.len-1:
        let b = hashchain[hashchain.len-i]
        let pb = hashchain[hashchain.len-i - 1]
        if b.prevHash != ($sha256.digest($pb)).toLower():
            return false

    # 先頭は, prevHashがivと等しいかチェック
    if hashchain[0].prevHash != iv:
        return false
    
    return true



proc main() =
    let datalist = @["0001", "0002", "0003", "0004"]
    let iv = "0000"

    let hashchain = genHashchain(iv, datalist)
    
    echo check(iv, hashchain)


when isMainModule:
    main()
