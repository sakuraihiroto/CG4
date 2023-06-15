#pragma once
#include "Sprite.h"

class PostEffect :
    public Sprite
{
public:

    PostEffect();

    void Initialize();

    void PreDrawScene(ID3D12GraphicsCommandList* cmdList);

    void PostDrawScene(ID3D12GraphicsCommandList* cmdList);

    void CreateGraphicsPipelineState();

    void Draw(ID3D12GraphicsCommandList* cmdList);

private: //メンバ変数

    //テクスチャバッファ
    ComPtr<ID3D12Resource> texBuff[2];
    //SRV用デスクリプタヒープ
    ComPtr<ID3D12DescriptorHeap> descHeapSRV;
    //深度バッファ
    ComPtr<ID3D12Resource> depthBuff;
    //RTV用デスクリプタヒープ
    ComPtr<ID3D12DescriptorHeap> descHeapRTV;
    //DSV用デスクリプタヒープ
    ComPtr<ID3D12DescriptorHeap> descHeapDSV;
    //グラフィックスパイプライン
    ComPtr<ID3D12PipelineState> pipelineState;
    //ルートシグネチャ
    ComPtr<ID3D12RootSignature> rootSignature;

private: //静的メンバ変数

    static const float clearColor[4];

};

