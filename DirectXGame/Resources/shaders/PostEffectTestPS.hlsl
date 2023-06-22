#include "PostEffectTest.hlsli"

Texture2D<float4> tex0 : register(t0);  // 0番スロットに設定されたテクスチャ
Texture2D<float4> tex1 : register(t1);  // 1番スロットに設定されたテクスチャ
SamplerState smp : register(s0);      // 0番スロットに設定されたサンプラー

float4 main(VSOutput input) : SV_TARGET
{
	float4 colortex0 = tex0.Sample(smp,input.uv);
	float4 colortex1 = tex1.Sample(smp,input.uv);

	//色反転
	colortex0.rgb = 1 - colortex0.rgb;

	//平均ぼかし
	//U座標1pixel分の変化量
	float2 u = 1.0f / 1280.0f;
	//V座標1pixel分の変化量
	float2 v = 1.0f / 720.0f;
	//横のマス目数
	int x = 5;
	//縦のマス目数
	int y = 5;
	//色合計変数を{0,0,0,0}で初期化
	colortex1 = (0,0,0,0);
	//縦方向に移動しながら繰り返す
	for (int j = -y / 2; j <= y / 2; j++)
	{
		//横方向に移動しながら繰り返す
		for (int i = -x / 2; i <= x / 2; i++)
		{
			//ピクセルの色をサンプリングし,合計に足す
			colortex1.rgb += tex1.Sample(smp, input.uv + (i * u) + (j * v));
		}
	}
	//合計色を縦x横のマス目数で割ってreturn(平均値)
	colortex1.rgb = colortex1.rgb / (x * y);

	//uvのvを0.1で割って余りが0.05未満ならcolortex1
	//そうでなければcolortex0を採用
	float4 color = colortex0;
	if (fmod(input.uv.y,0.1f) < 0.05f) {
		color = colortex1;
	}

	return float4(color.rgb,1);

}