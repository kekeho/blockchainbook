import nimcrypto

proc main() =
    echo $sha256.digest("12345")
    echo $sha256.digest("12346")


when isMainModule:
    main()
