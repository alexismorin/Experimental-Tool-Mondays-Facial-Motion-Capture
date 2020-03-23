// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Vertex Color Blend"
{
	Properties
	{
		_Base("Base", Color) = (1,0,0,0)
		_Wear("Wear", Color) = (0.7924528,0.7924528,0.7924528,0)
		_AO("AO", Color) = (0.254717,0.254717,0.254717,0)
		_Label("Label", Color) = (0.05918475,0.2378805,0.6603774,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float4 vertexColor : COLOR;
		};

		uniform float4 _Base;
		uniform float4 _AO;
		uniform float4 _Wear;
		uniform float4 _Label;

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
-31;731;1507;464;1234.956;193.7163;1.3;True;True
Node;AmplifyShaderEditor.VertexColorNode;1;-577.5,15;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;2;-637.5,-279;Inherit;False;Property;_Base;Base;0;0;Create;True;0;0;False;0;1,0,0,0;1,0.7122642,0.9858933,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;3;-740.5,-93;Inherit;False;Property;_AO;AO;2;0;Create;True;0;0;False;0;0.254717,0.254717,0.254717,0;1,0.476415,0.9713104,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;6;-364.5,-88;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;4;-265.3,-254.4001;Inherit;False;Property;_Wear;Wear;1;0;Create;True;0;0;False;0;0.7924528,0.7924528,0.7924528,0;0.990566,0.4251958,0.9597276,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;11;-418.5555,223.5836;Inherit;False;Step Antialiasing;-1;;1;2a825e80dfb3290468194f83380797bd;0;2;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;7;-39.59999,-84.80004;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;10;-126.0557,145.5836;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;-326.1,284;Inherit;False;Property;_Label;Label;3;0;Create;True;0;0;False;0;0.05918475,0.2378805,0.6603774,0;1,0.7122642,0.9842337,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;8;52.7,86.50004;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StepOpNode;9;-311.9557,139.0836;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;230.1,-18.2;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;Vertex Color Blend;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;2;0
WireConnection;6;1;3;0
WireConnection;6;2;1;1
WireConnection;11;1;1;3
WireConnection;7;0;6;0
WireConnection;7;1;4;0
WireConnection;7;2;1;2
WireConnection;10;0;11;0
WireConnection;8;0;7;0
WireConnection;8;1;5;0
WireConnection;8;2;10;0
WireConnection;9;0;1;3
WireConnection;0;2;8;0
ASEEND*/
//CHKSM=3F3FE31FAAB0B2BA56308AAF228DE2F4E97C37A8