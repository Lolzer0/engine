// Fluttering flag vertex shader

// These lines are just for EffectEdit:
string XFile = "flag.x";   // model
int    BCLR = 0xff000000;          // background colour

texture Tex0, Tex1, Tex2, Tex3, Tex4, Tex5, Tex6, Tex7;

bool selected = false;

// transformations provided by the app as input:
//float4x4 matWorldViewProj: WORLDVIEWPROJECTION;
float4x4 matProj: PROJECTION;
float4x4 matWorld  : WORLD;
float4x4 matView  : VIEW;
float4x4 matPosition;
float time: TIME;

struct VS_OUTPUT
{
    float4 Pos : POSITION;
    float2 tex : TEXCOORD0;
	float2 tex2 : TEXCOORD1;
	float psize: PSIZE;
};


float3 posMouse;
float size = 0;
bool needDraw = false;

float uTranslation;
float vTranslation;

float dist = 3.703;

VS_OUTPUT VS(float4 Pos : POSITION, float4 weight : BLENDWEIGHT0,  int4  matrixIndices : BLENDINDICES0, float3 Norm : NORMAL,  float2 tex : TEXCOORD0,float2 tex2 : TEXCOORD1)
{
    VS_OUTPUT Out = (VS_OUTPUT)0; 	
	
	Out.Pos.xyz = Pos.xyz;
	
	float3 P = mul(Out.Pos, matWorld);
	Out.Pos = mul(float4(P, 1), matView);

	Out.Pos = mul(Out.Pos, matProj);
	Out.psize = 5;
    // Just pass the texture co-ordinate as is
	

    Out.tex = tex; 
	Out.tex[0] += uTranslation;
	Out.tex[1] += vTranslation;
	
	Out.tex2 = tex2;
	if(!needDraw){
		Out.tex2[0] = 0;
		Out.tex2[1] = 0;
	}else{
		float tmpSize = size *2;
		float tx = Pos.xyz[0] - posMouse[0];
		float tz = Pos.xyz[2] - posMouse[2];
		
		float x = 0.5+ tx / tmpSize;
		Out.tex2[0] = x;
		
		float z = 0.5+ tz / tmpSize;
		Out.tex2[1] = z;

	}
	

    return Out;
}

struct PSOutput
{
    float4 colour : COLOR;
//	float Depth0 : DEPTH;

	
};

sampler ColorMapSampler = sampler_state 
{ 
   Texture = <Tex0>; 
   AddressU  = Clamp; 
   AddressV  = Clamp; 
    //AddressU  = WRAP; 
	//AddressV  = WRAP; 
}; 

sampler ColorMapSampler1 = sampler_state 
{ 
   Texture = <Tex1>; 
    AddressU  = Clamp; 
	AddressV  = Clamp; 
};

sampler ColorMapSampler2 = sampler_state 
{ 
   Texture = <Tex2>; 
    AddressU  = Clamp; 
	AddressV  = Clamp; 
};  

sampler ColorMapSampler3 = sampler_state 
{ 
   Texture = <Tex3>; 
    AddressU  = Clamp; 
	AddressV  = Clamp; 
}; 

sampler ColorMapSampler4 = sampler_state 
{ 
   Texture = <Tex4>; 
    AddressU  = Clamp; 
	AddressV  = Clamp; 
}; 

sampler ColorMapSampler5 = sampler_state 
{ 
   Texture = <Tex5>; 
   AddressU  = Clamp; 
   AddressV  = Clamp; 
}; 

sampler ColorMapSampler6 = sampler_state 
{ 
   Texture = <Tex6>; 
   AddressU  = Clamp; 
   AddressV  = Clamp; 
}; 

sampler ColorMapSampler7 = sampler_state 
{ 
   Texture = <Tex7>; 
   AddressU  = Clamp; 
   AddressV  = Clamp; 
}; 


float4 blendColours(float4 color1, float2 InTex, sampler smplr){
	float4 color2 = tex2D(smplr, InTex); 
	if(color2[3] < 1.0 && color2[3] > 0.0 || (color2[2] > 0.0 || color2[1] > 0.0 || color2[0] > 0.0)){
		color1[0] = color2[0];
		color1[1] = color2[1];
		color1[2] = color2[2];
		color1[3] = color2[3];
	}
	return color1;
}



// Pixel shader that calculates ambient light
PSOutput PS(float2 vPos : VPOS, float4 colour: COLOR, float2 InTex: TEXCOORD0,float2 InTex1: TEXCOORD1, float4 Pos : POSITION)
{
	
    PSOutput Out=(PSOutput)0;
	Out.colour[1] = 1;
	Out.colour[3] = 1;
	
	
	Out.colour = blendColours(Out.colour, InTex, ColorMapSampler);
	Out.colour = blendColours(Out.colour, InTex, ColorMapSampler1);
	Out.colour = blendColours(Out.colour, InTex, ColorMapSampler2);
	Out.colour = blendColours(Out.colour, InTex, ColorMapSampler3);
	Out.colour = blendColours(Out.colour, InTex, ColorMapSampler4);
	if(needDraw){
		Out.colour[0] = 1;
		Out.colour[3] = 0;
		Out.colour = blendColours(Out.colour, InTex1, ColorMapSampler5);
	}
	

    return Out; 
}


// Effect technique to be used
technique TVertexShaderOnly
{
    pass P0
    {
	  
	
      ZENABLE = TRUE;
      SRCBLEND = SRCALPHA;
      DESTBLEND = INVSRCALPHA;
      CULLMODE = CW;
      ALPHABLENDENABLE = TRUE;
      LIGHTING = TRUE;
	  //FILLMODE=SOLID;


   PixelShader  = compile ps_3_0 PS();
    VertexShader = compile vs_3_0 VS();

    }  

	  
}

