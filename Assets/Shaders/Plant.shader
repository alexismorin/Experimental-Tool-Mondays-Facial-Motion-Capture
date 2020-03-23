// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Plant"
{
	Properties
	{
		_Base("Base", Color) = (1,0,0,0)
		_Wear("Wear", Color) = (0.7924528,0.7924528,0.7924528,0)
		_AO("AO", Color) = (0.254717,0.254717,0.254717,0)
		_Label("Label", Color) = (0.05918475,0.2378805,0.6603774,0)
		_Deform("Deform", Range( 0 , 1)) = 1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float4 vertexColor : COLOR;
		};

		uniform float _Deform;
		uniform float4 _Base;
		uniform float4 _AO;
		uniform float4 _Wear;
		uniform float4 _Label;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float2 panner15 = ( 1.0 * _Time.y * float2( 0.5,0.25 ) + (ase_worldPos).xz);
			float simplePerlin2D12 = snoise( panner15*0.5 );
			simplePerlin2D12 = simplePerlin2D12*0.5 + 0.5;
			float temp_output_16_0 = ( simplePerlin2D12 * _Deform );
			float3 appendResult19 = (float3(temp_output_16_0 , 0.0 , temp_output_16_0));
			v.vertex.xyz += appendResult19;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 lerpResult6 = lerp( _Base , _AO , i.vertexColor.r);
			float4 lerpResult7 = lerp( lerpResult6 , _Wear , i.vertexColor.g);
			float temp_output_3_0_g1 = ( 0.5 - i.vertexColor.b );
			float4 lerpResult8 = lerp( lerpResult7 , _Label , ( 1.0 - saturate( ( temp_output_3_0_g1 / fwidth( temp_output_3_0_g1 ) ) ) ));
			o.Emission = lerpResult8.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17800
144;675;1507;470;1321.696;-309.3369;1.425363;True;True
Node;AmplifyShaderEditor.WorldPosInputsNode;13;-575.8561,526.4838;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ComponentMaskNode;14;-352.2562,526.4836;Inherit;False;True;False;True;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;3;-740.5,-93;Inherit;False;Property;_AO;AO;2;0;Create;True;0;0;False;0;0.254717,0.254717,0.254717,0;0.7547169,0.7547169,0.7547169,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;15;-124.7562,506.9837;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.5,0.25;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.VertexColorNode;1;-577.5,15;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;2;-637.5,-279;Inherit;False;Property;_Base;Base;0;0;Create;True;0;0;False;0;1,0,0,0;0.8773585,0.8773585,0.8773585,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;12;37.74395,457.5836;Inherit;False;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;6;-364.5,-88;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-44.15737,714.0093;Inherit;False;Property;_Deform;Deform;4;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-265.3,-254.4001;Inherit;False;Property;_Wear;Wear;1;0;Create;True;0;0;False;0;0.7924528,0.7924528,0.7924528,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;11;-418.5555,223.5836;Inherit;False;Step Antialiasing;-1;;1;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;7;-39.59999,-84.80004;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;10;-126.0557,145.5836;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;-326.1,284;Inherit;False;Property;_Label;Label;3;0;Create;True;0;0;False;0;0.05918475,0.2378805,0.6603774,0;0.3938679,0.459336,0.5,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;247.5436,534.8837;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;19;484.7723,507.7568;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StepOpNode;9;-311.9557,139.0836;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;8;52.7,86.50004;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;230.1,-18.2;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Plant;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;13;0
WireConnection;15;0;14;0
WireConnection;12;0;15;0
WireConnection;6;0;2;0
WireConnection;6;1;3;0
WireConnection;6;2;1;1
WireConnection;11;1;1;3
WireConnection;7;0;6;0
WireConnection;7;1;4;0
WireConnection;7;2;1;2
WireConnection;10;0;11;0
WireConnection;16;0;12;0
WireConnection;16;1;17;0
WireConnection;19;0;16;0
WireConnection;19;2;16;0
WireConnection;9;0;1;3
WireConnection;8;0;7;0
WireConnection;8;1;5;0
WireConnection;8;2;10;0
WireConnection;0;2;8;0
WireConnection;0;11;19;0
ASEEND*/
//CHKSM=C6B32ED8E9BC6DA8E1A6E2D9998B3BEB6FCA1370