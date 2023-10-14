@file:OptIn(ExperimentalResourceApi::class)

package io.github.alexzhirkevich.shared
import androidx.compose.foundation.Image
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Face
import androidx.compose.material3.TextField
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.BlendMode
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.ColorFilter
import androidx.compose.ui.graphics.painter.Painter
import androidx.compose.ui.graphics.vector.rememberVectorPainter
import androidx.compose.ui.unit.dp
import io.github.alexzhirkevich.qrose.options.QrBallShape
import io.github.alexzhirkevich.qrose.options.QrBrush
import io.github.alexzhirkevich.qrose.options.QrCodeShape
import io.github.alexzhirkevich.qrose.options.QrErrorCorrectionLevel
import io.github.alexzhirkevich.qrose.options.QrFrameShape
import io.github.alexzhirkevich.qrose.options.QrLogoPadding
import io.github.alexzhirkevich.qrose.options.QrLogoShape
import io.github.alexzhirkevich.qrose.options.QrPixelShape
import io.github.alexzhirkevich.qrose.options.brush
import io.github.alexzhirkevich.qrose.options.circle
import io.github.alexzhirkevich.qrose.options.hexagon
import io.github.alexzhirkevich.qrose.options.image
import io.github.alexzhirkevich.qrose.options.roundCorners
import io.github.alexzhirkevich.qrose.rememberQrCodePainter
import kotlinx.coroutines.delay
import org.jetbrains.compose.resources.ExperimentalResourceApi
import org.jetbrains.compose.resources.painterResource
import org.jetbrains.skiko.currentNanoTime


//@DelicateQRoseApi
@Composable
fun App() {

    var text by remember {
        mutableStateOf("https://github.com/alexzhirkevich/qrose")
    }

//    rememberQrCodePainter(text, QrOptions(
//        shapes = QrShapes(
//            code = QrCodeShape.hexagon(),
//            ball = QrBallShape.circle(),
//            darkPixel = QrPixelShape.roundCorners(),
//            frame = QrFrameShape.roundCorners(.25f),
//        ),
//        fourEyed = true
//    ))
    val bg = painterResource("jcbg.png")
    val logo = painterResource("jc.png")

    val painter = rememberQrCodePainter(text) {
        fourEyed = true

        logo {
            painter = logo
            padding = QrLogoPadding.Natural(.1f)
            shape = QrLogoShape.circle()
            size = 0.125f
        }

        errorCorrectionLevel = QrErrorCorrectionLevel.Low

        shapes(centralSymmetry = true) {
            pattern = QrCodeShape.hexagon()
            ball = QrBallShape.roundCorners(.25f, bottomRight = false)
            darkPixel = QrPixelShape.roundCorners()
            frame = QrFrameShape.roundCorners(.25f, bottomRight = false)
        }
        colors {
            dark = QrBrush.image(bg,)
        }
    }


    Column(
        modifier = Modifier.fillMaxSize(),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Image(
            painter = painter,
            contentDescription = null,
            modifier = Modifier
                .size(350.dp)
                .padding(10.dp)
        )

        TextField(
            value = text,
            onValueChange = { text = it }
        )
    }
}

@Composable
fun Jc() : Painter {
    val bg = painterResource("jcbg.png")
    val logo = painterResource("jc.png")

    return rememberQrCodePainter("https://github.com/alexzhirkevich/qrose") {
        fourEyed = true

        logo {
            painter = logo
            padding = QrLogoPadding.Natural(.1f)
            shape = QrLogoShape.circle()
            size = 0.125f
        }

        errorCorrectionLevel = QrErrorCorrectionLevel.MediumHigh

        shapes(centralSymmetry = true) {
            pattern = QrCodeShape.hexagon()
            ball = QrBallShape.roundCorners(.25f, bottomRight = false)
            darkPixel = QrPixelShape.roundCorners()
            frame = QrFrameShape.roundCorners(.25f, bottomRight = false)
        }
        colors {
            dark = QrBrush.image(bg,)
        }
    }
}