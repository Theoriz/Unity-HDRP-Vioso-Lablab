using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.HighDefinition;
using System;

[Serializable, VolumeComponentMenu("Post-processing/Custom/TextureBlitPostProcess")]
public sealed class TextureBlitPostProcess : CustomPostProcessVolumeComponent, IPostProcessComponent
{
    [Tooltip("Textures to blit.")]
    public TextureParameter textureToBlit1 = new TextureParameter(null);
    public TextureParameter textureToBlit2 = new TextureParameter(null);
    public TextureParameter textureToBlit3 = new TextureParameter(null);
    public TextureParameter textureToBlit4 = new TextureParameter(null);
    public Vector2Parameter inputResolution = new Vector2Parameter(Vector2.one);
    //public BoolParameter flipX = new BoolParameter(false);
    //public BoolParameter flipY = new BoolParameter(false);

    Material m_Material;

    public bool IsActive() => m_Material != null && textureToBlit1.value != null && textureToBlit2.value != null && textureToBlit3.value != null && textureToBlit4.value != null;

    public override CustomPostProcessInjectionPoint injectionPoint => CustomPostProcessInjectionPoint.AfterPostProcess;

    // Disable in scene view
    public override bool visibleInSceneView => false;

public override void Setup() {
        if (Shader.Find("Hidden/Shader/TextureBlitPostProcess") != null)
            m_Material = new Material(Shader.Find("Hidden/Shader/TextureBlitPostProcess"));
    }

    public override void Render(CommandBuffer cmd, HDCamera camera, RTHandle source, RTHandle destination) {
        if (m_Material == null)
            return;

        m_Material.SetVector("_InputResolution", inputResolution.value);
        m_Material.SetTexture("_TextureToBlit1", textureToBlit1.value);
        m_Material.SetTexture("_TextureToBlit2", textureToBlit2.value);
        m_Material.SetTexture("_TextureToBlit3", textureToBlit3.value);
        m_Material.SetTexture("_TextureToBlit4", textureToBlit4.value);
        //m_Material.SetInt("_FlipX", flipX.value ? 1 : 0);
        //m_Material.SetInt("_FlipY", flipY.value ? 1 : 0);

        HDUtils.DrawFullScreen(cmd, m_Material, destination);
    }

    public override void Cleanup() => CoreUtils.Destroy(m_Material);
}
