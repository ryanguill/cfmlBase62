
<cfscript>
/*
    juuid = createObject("java", "java.util.UUID");
    
    writedump(juuid);
    
    uid = juuid.fromString('f0f8cd6c-aae0-4c5b-ac5e-511b6cde9c41');
    
    writedump(uid);
    writedump(uid.toString());
    writedump(uid.getLeastSignificantBits());
    writedump(uid.getMostSignificantBits());

	writedump(juuid.init(uid.getMostSignificantBits(), uid.getLeastSignificantBits()).toString());

	base62 = new lib.base62();

	//writedump(base62);

	x = base62.fromBase10(uid.getLeastSignificantBits());
	y = base62.toBase10(x);
	writedump(x);
	writedump(y);

*/
	juuid = createObject("java", "java.util.UUID");
	base62 = new lib.base62();
	//writedump(createUUID());
	uid = createObject("java", "java.util.UUID").fromString('191fc4e5-8023-4704-8fb5-8f07dd1c13aa'); //.randomUUID();
	//uid = createObject("java", "java.util.UUID").randomUUID();
	x = base62.fromUUID(uid);
	y = base62.toUUID(x);

	writedump(uid.toString());
	writedump(x);
	writedump(y);
	most = uid.getMostSignificantBits();
	least = uid.getLeastSignificantBits();
	writedump(most);
	//writedump(getMetadata(most));
	writedump(least);
	m = 1810382065202579200;
	writedump(m);
	l = -8091403891564080128;
	writedump(l);
	//writedump(getMetadata(m));
	writedump(juuid.init(m, l).toString());
	writedump(juuid.init(most, least).toString());
	
	writeoutput("<hr />");
	writedump(most);
	writedump(m.longValue());
	writedump(most == m);
	writedump(most.equals(m));
	writedump(m.longValue());
	writedump(m.longValue().toString());
	writedump(createObject("java", "java.lang.Long").toHexString(most));
	writedump(createObject("java", "java.lang.Long").toHexString(m));

	writedump(createObject("java", "java.lang.Long").toHexString(least));
	writedump(createObject("java", "java.lang.Long").toHexString(l));
	writedump(createObject("java", "java.lang.Long").lowestOneBit(least));
	writedump(createObject("java", "java.lang.Long").lowestOneBit(l));
	writedump(createObject("java", "java.lang.Long").lowestOneBit(most));
	writedump(createObject("java", "java.lang.Long").lowestOneBit(m));

	writedump(getMetadata(m.longValue()));

</cfscript>